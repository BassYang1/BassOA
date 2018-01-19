<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试页面</title>
</head>

<body>
	<button id="test3">test3</button>
</body>
</html>

<script>
//originFun为原函数，before和after为增强方法
function constructor(originFun, before, after){
    function _class(){
        before.apply(this, arguments);
        originFun.apply(this, arguments);
        after.apply(this, arguments);
    }
    return _class;
}

//加法运算，作为测试的原函数
function calcAdd(a,b){
	var dt = new Date();
    var expired = dt.getTime() + 5000;
    while(true){
    	dt = new Date();
    	if(dt.getTime() > expired){
    		break;
    	}
    }
    
    console.log(a + "+" + b + "=" + (a + b));
}

// AOP增强

	calcAdd = constructor(calcAdd, function() {
		document.getElementById("test3").setAttribute("disabled", "disabled");
		document.getElementById("test3").setAttribute("style", "color:red");
		console.log("我在原方法前执行")
	}, function() {
		document.getElementById("test3").removeAttribute("disabled");
		document.getElementById("test3").removeAttribute("style");
		console.log("我在原方法后执行")
	});


	document.getElementById("test3").onclick = function() {
		calcAdd(2, 3);
		console.log("处理完成");
	};
</script>
<script>
/* document.getElementById("test3").onclick = function() {
	var __self = this;
	function fn() {
		console.log(__self == this);
		console.log(__self);
		console.log(this);
	}

	fn();
};  */
	/* document.getElementById("test3").onclick = function() {
		function fn() {
			console.log(this);
		}
		fn.call(this);
	}; */

	/* var temp;

	function fn(a, b, c, d) {
		console.log(this);
		console.log(a, b, c, d);
	}
	//call
	fn.call(temp, 1, 2, 3);
	//apply
	fn.apply(temp, [ 1, 2, 3 ]);
	//bind
	var f = fn.bind(temp, 1, 2, 3);
	f(4); */
</script>
<script>
//例8
/* function Cls(){
	this.msg = "Cls属性字段";	
	this.func = function(){
		console.log(this.msg); //Cls属性字段
	    console.log(this); //this==obj
	};

	//return {}; //异常
    //return function(){}; //异常
    //return 1; //正常执行
    //return null; //正常执行
    //return ""; //正常执行
    return undefined; //正常执行
}

var obj = new Cls;
obj.func(); //window.obj.func()
console.log(obj.msg); //window.obj.msg
 */
//例7
/* function Cls(){
	this.msg = "Cls属性字段";
	
	this.func = function(){
		console.log("===obj===");
		console.log(this.msg); //Cls属性字段
	    console.log(this); //this==obj
    	console.log(this==obj); //this==obj
        console.log(Cls==obj); //Cls==obj
	}	

	console.log("===Cls===");
	console.log(this.msg); //Cls属性字段
    console.log(this); //this==Cls    
    console.log(this==Cls); //this==Cls
    console.log(this==window); //this==window
}

var obj = new Cls();
obj.func(); //window.obj.func()
console.log("===window===");
console.log(window.obj.msg); //window.obj.msg
console.log(this==window); //this==window
console.log(Cls==obj); //Cls==obj */

//例6
/* var objA = {
	msg: "objA的msg属性", 
	func: function(){
		console.log(this.msg); //objA的msg属性
	    console.log(this); //this==objA
	},
	objB: {
		msg: "objB的msg属性",
		func: function(){
			console.log(this.msg); //objB的msg属性
		    console.log(this); //this==objB
		}
	}
}

//如果变量或方法未定义在object或function内部，在非严格版JS下，默认调用对象是window对象。
var f = objA.objB.func; //变量指向func的引用，
f(); //this指向当前调用对象window */

//例5
/* var objA = {
	msg: "objA的msg属性", 
	func: function(){
		console.log(this.msg); //objA的msg属性
	    console.log(this); //this==objA
	},
	objB: {
		msg: "objB的msg属性",
		func: function(){
			console.log(this.msg); //objB的msg属性
		    console.log(this); //this==objB
		}
	}
}

objA.func(); //直接调用对象是objA
objA.objB.func(); //直接调用对象是objB */
//例4
/* var objA = {
	msg: "objA的msg属性", 
	objB: {
		msg: "objB的msg属性",
		func: function(){
			console.log(this.msg); //objB的msg属性
		    console.log(this); //this==objB
		}
	}
}

objA.objB.func(); */

//例3
/* var obj = {
	msg: "obj调用了func",
	func: function(){
		console.log(this.msg); //obj调用了func
	    console.log(this); //this==obj
	}
}

window.obj.func(); */
//例2
/* function func(){
    var msg = "window调用了func";
    console.log(this.msg); //undefined
    console.log(this); //this==window
    this.msg1="134353";
}

func(); //window.func(); 默认被window对象调用  
console.log(func.msg1);  */

//例1
/* var obj = {
	msg: "obj调用了func",
	func: function(){
		console.log(this.msg); //obj调用了func
	    console.log(this); //this==obj
	}
}

obj.func(); 
console.log(obj.msg); */
</script>

<script>
Function.prototype.before = function(func){
	var _self = this;
	
	return function(){
		if(func.apply(this, arguments) === false){
			return false;
		}
		
		return _self.apply(this, arguments);
	}
};

Function.prototype.after = function(func){
	var _self = this;
	
	return function(){
		var ret = _self.apply(this, arguments);
		
		if(ret == false){
			return false;
		}
		
		func.apply(this, arguments);
		return ret;
	}
};

//1
/* window.onload = function(){
	alert(1);
	alert(2);
}; */

//2
/* window.onload = function(){
	console.log(1);
}

var __onload = window.onload;

window.onload = function(){
	if(__onload){
		__onload();
	}
	
	console.log(2);
} */

/* window.onload = function(){
	console.log(1);
}

window.onload = (window.onload || function(){}).after(function(){
	console.log(2);
}) */
</script>

<script type="text/javascript">
	/* function baseClass() {
		this.showMsg = function() {
			console.log("baseClass::showMsg");
		}

		this.baseShowMsg = function() {
			console.log("baseClass::baseShowMsg");
		}
	}
	
	baseClass.showMsg = function() {
		console.log("baseClass::showMsg static");
	}

	function extendClass() {
		this.showMsg = function() {
			console.log("extendClass::showMsg");
		}
	}
	
	extendClass.showMsg = function() {
		console.log("extendClass::showMsg static");
	}

	extendClass.prototype = new baseClass();
	var instance = new extendClass();

	instance.showMsg(); //显示extendClass::showMsg
	instance.baseShowMsg(); //显示baseClass::baseShowMsg
	instance.showMsg(); //显示extendClass::showMsg
	instance.showMsg.call(instance);//显示extendClass::showMsg

	baseClass.showMsg.call(instance);//显示baseClass::showMsg static

	var baseinstance = new baseClass();
	baseinstance.showMsg();//显示baseClass::showMsg
	baseinstance.showMsg.call(instance);//显示baseClass::showMsg  */
</script>


