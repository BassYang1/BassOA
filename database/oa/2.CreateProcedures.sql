USE MissionskyOA
GO

/**************************************************************
--ͳ��Ա�������� p_summaryAttendanceDetail
--**************************************************************/

IF EXISTS (SELECT 1 FROM SysObjects WHERE name = N'p_summaryAttendanceDetail' AND  xtype='P')
	DROP PROC p_summaryAttendanceDetail
GO

CREATE PROC p_summaryAttendanceDetail(
	@date DATETIME --ͳ������
) AS
BEGIN
	IF EXISTS(SELECT 1 FROM tempdb..SYSOBJECTS WHERE Id = OBJECT_ID('tempdb..##TOrder'))
		DROP TABLE ##TOrder
		
	--DECLARE @date DATE --ͳ������
	--SET @date = '2016-03-28'
	DECLARE @loop INT --ѭ������
	DECLARE @sumDate DATE --ͳ������
	DECLARE @firstDay DATE, @lastDay DATE --ͳ���·ݵĵ�һ������һ��
	DECLARE @workday BIT --�Ƿ��ǹ�����
	DECLARE @holidayType NVARCHAR(16), @workdayType NVARCHAR(16) --��������

	SET @firstDay = DATEADD(dd, -DAY(@date) + 1, @date)
	SET @lastDay = DATEADD(dd, -1, DATEADD(mm, 1, @firstDay))
	SET @holidayType = CAST(Year(GETDATE()) AS NVARCHAR(4)) + '��������' --��������
	SET @workdayType = CAST(Year(GETDATE()) AS NVARCHAR(4)) + '��ĩ����'

	--Ա���˴�ͳ����Ч������
	SELECT O.Id, O.UserId, O.OrderNo, O.OrderType, O.RefOrderId, O.Status, D.StartDate, D.StartTime, D.EndDate, D.EndTime, D.IOHours, (CASE WHEN StartDate > EndDate THEN 1 ElSE 0 END) AS OverDay INTO ##TOrder 
	FROM [Order] O INNER JOIN OrderDet D ON O.Id = D.OrderId
	WHERE 1 > 0
	AND ISNULL(O.Status, -1) IN (0, 1, 2, 5) --0:���룬1:������, 2:��׼, 5:����
	AND ((D.StartDate >= @firstDay AND D.EndDate <= @lastDay) OR (D.StartDate < @firstDay AND D.EndDate >= @firstDay))
	
	SET @loop = DAY(@lastDay) --��ȡѭ������
	DELETE FROM AttendanceSummaryDetail WHERE DATEDIFF(mm, SumDate, @date) = 0 --���ͳ���·ݵĻ�����Ϣ
	
	WHILE(@loop > 0)
	BEGIN
		SET @sumDate = DATEADD(dd, (-1 * @loop + 1), @lastDay)

		--���������Ƿ��ǹ�����
		SET @workday = CASE WHEN DATEPART(WEEKDAY, @sumDate) = 7 OR DATEPART(WEEKDAY, @sumDate) = 1 THEN 0 ELSE 1 END --�Ƿ�Ϊ��ĩ
		SELECT @workday = 1 FROM DataDict WHERE @workday = 1 OR (Type = @workdayType AND Value = CONVERT(NVARCHAR(8), @sumDate, 112)) --�Ƿ�Ϊ��ĩ����
		SELECT @workday = 0 FROM DataDict WHERE @workday = 1 AND Type = @holidayType AND Value = CONVERT(NVARCHAR(8), @sumDate, 112) --�Ƿ�Ϊ��������
	
		--ͳ��Ա��������ϸ
		INSERT INTO AttendanceSummaryDetail (UserId, SumDate, WorkHours, OrderHours, FixedHC)
		SELECT U.Id, CONVERT(NVARCHAR(8), @sumDate, 112),
		--��Ч����ʱ����������7.5 + ����Ӱ�����ʱ��(���쵱�찴7.5Сʱ)
		(CASE @workday WHEN 1 THEN 7.5 ELSE 0.0 END) + ISNULL((SELECT SUM(CASE OverDay WHEN 1 THEN (CASE WHEN IOHours < -7.5 THEN -7.5 WHEN IOHours > 7.5 THEN 7.5 ELSE IOHours END) ELSE IOHours END) FROM ##TOrder WHERE UserId = U.Id AND StartDate <= @sumDate AND EndDate >= @sumDate), 0.0),
		--���Ѽ���
		ISNULL((SELECT SUM(CASE WHEN OverDay = 1 AND IOHours < -7.5 THEN -7.5 ELSE IOHours END) FROM ##TOrder WHERE OrderType NOT IN (4, 8, 11) AND UserId = U.Id AND StartDate <= @sumDate AND EndDate >= @sumDate), 0.0),
		(CASE WHEN D.Name = N'����' THEN 1 ELSE 0 END)
		FROM [User] U, Department D
		WHERE U.Available = 1 AND U.DeptId = D.Id
		
		SET @loop = @loop - 1
	END
	
	IF EXISTS(SELECT 1 FROM tempdb..SYSOBJECTS WHERE Id = OBJECT_ID('tempdb..##TOrder'))
		DROP TABLE ##TOrder
END
GO