USE MissionskyOA
GO

/**************************************************************
--统计员工出勤率 p_summaryAttendanceDetail
--**************************************************************/

IF EXISTS (SELECT 1 FROM SysObjects WHERE name = N'p_summaryAttendanceDetail' AND  xtype='P')
	DROP PROC p_summaryAttendanceDetail
GO

CREATE PROC p_summaryAttendanceDetail(
	@date DATETIME --统计日期
) AS
BEGIN
	IF EXISTS(SELECT 1 FROM tempdb..SYSOBJECTS WHERE Id = OBJECT_ID('tempdb..##TOrder'))
		DROP TABLE ##TOrder
		
	--DECLARE @date DATE --统计日期
	--SET @date = '2016-03-28'
	DECLARE @loop INT --循环变量
	DECLARE @sumDate DATE --统计日期
	DECLARE @firstDay DATE, @lastDay DATE --统计月份的第一天和最后一天
	DECLARE @workday BIT --是否是工作日
	DECLARE @holidayType NVARCHAR(16), @workdayType NVARCHAR(16) --日历类型

	SET @firstDay = DATEADD(dd, -DAY(@date) + 1, @date)
	SET @lastDay = DATEADD(dd, -1, DATEADD(mm, 1, @firstDay))
	SET @holidayType = CAST(Year(GETDATE()) AS NVARCHAR(4)) + '法定假日' --日历类型
	SET @workdayType = CAST(Year(GETDATE()) AS NVARCHAR(4)) + '周末补班'

	--员工此次统计有效的申请
	SELECT O.Id, O.UserId, O.OrderNo, O.OrderType, O.RefOrderId, O.Status, D.StartDate, D.StartTime, D.EndDate, D.EndTime, D.IOHours, (CASE WHEN StartDate > EndDate THEN 1 ElSE 0 END) AS OverDay INTO ##TOrder 
	FROM [Order] O INNER JOIN OrderDet D ON O.Id = D.OrderId
	WHERE 1 > 0
	AND ISNULL(O.Status, -1) IN (0, 1, 2, 5) --0:申请，1:审批中, 2:批准, 5:撤销
	AND ((D.StartDate >= @firstDay AND D.EndDate <= @lastDay) OR (D.StartDate < @firstDay AND D.EndDate >= @firstDay))
	
	SET @loop = DAY(@lastDay) --获取循环次数
	DELETE FROM AttendanceSummaryDetail WHERE DATEDIFF(mm, SumDate, @date) = 0 --清除统计月份的汇总信息
	
	WHILE(@loop > 0)
	BEGIN
		SET @sumDate = DATEADD(dd, (-1 * @loop + 1), @lastDay)

		--计算日期是否是工作日
		SET @workday = CASE WHEN DATEPART(WEEKDAY, @sumDate) = 7 OR DATEPART(WEEKDAY, @sumDate) = 1 THEN 0 ELSE 1 END --是否为周末
		SELECT @workday = 1 FROM DataDict WHERE @workday = 1 OR (Type = @workdayType AND Value = CONVERT(NVARCHAR(8), @sumDate, 112)) --是否为周末补班
		SELECT @workday = 0 FROM DataDict WHERE @workday = 1 AND Type = @holidayType AND Value = CONVERT(NVARCHAR(8), @sumDate, 112) --是否为法定假日
	
		--统计员工考勤详细
		INSERT INTO AttendanceSummaryDetail (UserId, SumDate, WorkHours, OrderHours, FixedHC)
		SELECT U.Id, CONVERT(NVARCHAR(8), @sumDate, 112),
		--有效工作时长：工作日7.5 + 当天加班或请假时间(跨天当天按7.5小时)
		(CASE @workday WHEN 1 THEN 7.5 ELSE 0.0 END) + ISNULL((SELECT SUM(CASE OverDay WHEN 1 THEN (CASE WHEN IOHours < -7.5 THEN -7.5 WHEN IOHours > 7.5 THEN 7.5 ELSE IOHours END) ELSE IOHours END) FROM ##TOrder WHERE UserId = U.Id AND StartDate <= @sumDate AND EndDate >= @sumDate), 0.0),
		--付费假期
		ISNULL((SELECT SUM(CASE WHEN OverDay = 1 AND IOHours < -7.5 THEN -7.5 ELSE IOHours END) FROM ##TOrder WHERE OrderType NOT IN (4, 8, 11) AND UserId = U.Id AND StartDate <= @sumDate AND EndDate >= @sumDate), 0.0),
		(CASE WHEN D.Name = N'国外' THEN 1 ELSE 0 END)
		FROM [User] U, Department D
		WHERE U.Available = 1 AND U.DeptId = D.Id
		
		SET @loop = @loop - 1
	END
	
	IF EXISTS(SELECT 1 FROM tempdb..SYSOBJECTS WHERE Id = OBJECT_ID('tempdb..##TOrder'))
		DROP TABLE ##TOrder
END
GO