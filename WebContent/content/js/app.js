/* 
 * @description 各种接口变量
===============================================================================================*/
var com = {};

(function(com, undefined){		
	//清空message
	com.clearMsg = function (selector){
		if(selector){
			$(selector).text("");
			$(selector).html("");
		}
	};
	
	//验证邮箱
	com.checkEmail = function(val){
		if(val == undefined || val == "" || typeof val != "string"){
			return false;
		}
		
		var reg = /^\w|\.+@\w+\.\w+$/g;
		return reg.test(val);
	};

	//验证Url
	com.checkUrl = function(val){
		if(val == undefined || val == "" || typeof val != "string"){
			return false;
		}
		
		var reg = /^((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?$/;
		return reg.test(val);
	};
	
	com.getToken = function(){
		if(tokenCookie){
			
		}
	};
	
	//ajax post请求
	com.post = function(url, data, async, success, fail){
		if($.trim(url) == "" || event == null){
			return null;
		}

		$.when($.ajax({
			url : url,
			dataType : "JSON",
			type : "POST",
			data : data
		}))
		.done(success)
		.fail(fail)
		.then(function(data) {
		});
	};
})(com);

com.api = {};

(function(api, undefined) {
	//获取顶部相关Html
	api.getTopbarHtml = '_topbar.html';
	
	//获取底部相关html
	api.getSidebarHtml = '_sidebar.html';
	
})(com.api);

//定义初使化参数
com.init = {};
(function(init, undefined) {
	init.style = function(){
		//用户菜单样式产设置
		$(".dropdown-menu").css("min-width", $(".user-menu").width());
	};
	
	//站点domain
	init.domain = $.trim(appDomain);
})(com.init);

/* 
 * Button点击事件处理
===============================================================================================*/
var MyButton = function(func){
	//获取事件
	this.event = window.event || arguments.callee.caller.arguments[0];
	this.event = this.event || {};
	
	//获取事件类型
	this.type = this.event.type;
	
	//获取事件触发元素
	this.target = this.event.target;
	
	//获取事件处理函数
	this.func = func;
};

MyButton.prototype = {
	off : function (){ //禁用Button			
		if(this.target){
			$(this.target).attr("disabled", true);
			$(this.target).addClass("disabled");
			
			if(this.type){
				$(this.target).off(this.type);
			}
		}
	},	
	on: function (){ //启用Button		
		if(this.target){
			$(this.target).removeAttr("disabled");
			$(this.target).removeClass("disabled");
			
			if(this.type){
				$(this.target).on(this.type, this.func);
			}
		}
	}
};
/* 
 * @description 控制侧边栏高度
===============================================================================================*/
function sidebarHeight(){
	var clientHeight = document.documentElement.clientHeight;//整个屏幕高度
	var topNavHeight = $("#topNav").height();//顶部高度
	var contentHeight = $(".main-content").height();//主内容高度
	//var navHeight = $("#sidebar").height();
					
	if((clientHeight-topNavHeight) >= contentHeight){
		$(".sidebar").height(clientHeight-topNavHeight);
	}else{
		$(".sidebar").height(contentHeight);
	}	
}


/* 
 * @description 加载头部
===============================================================================================*/
function getTopbarHtml(){
	$.ajax({
		type: "get",
		url: com.api.getTopbarHtml,
		success: function(data) {
			$('#topNav').html(data);
		}
	});
}

/* 
 * @description 加载侧导航栏
===============================================================================================*/
function getSidebarHtml(name,submenu){
	$.ajax({
		type: "get",
		url: com.api.getSidebarHtml,
		success: function(data) {
			$('#sidebar').html(data);
			$("#sidebar").find(".nav > li").each(function(i,e){
				if($(this).attr("data-html")==name){
					$(this).addClass("active");
					if(submenu){
						$(this).addClass("open");
						$(this).attr("data-blean", "false");
						$(this).find('b').css({"-webkit-transform" : "rotateX(180deg)"});
						$(this).find(".submenu").css({"display":"block"});
						$(this).find(".submenu>li").each(function(){
							if($(this).attr("data-html")==submenu){
								$(this).addClass("active");
							}
						});
					}
				}
			});			
		}
	});
}

//设置请求地址
function setRequestAddr(url){
	if(url == undefined){
		return com.init.domain;
	}

	var addr = com.init.domain;
	if(addr.length > 0 && addr.charAt(addr.length - 1) != "/"){
		addr += "/";
	}
	
	return addr + (url.length > 0 && url.charAt(0) == "/" ? url.substr(1) : url);
}
