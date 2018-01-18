<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试页面</title>
</head>

<script type="text/javascript">

	function Cls1() {
		this.say = function() {
			console.log("孙子，你爷爷来了");
		}

		this.name = "我们家姓杨";
	}

	function Cls2() {
		this.say = function() {
			console.log("儿子，你爸爸来了");
		}
	}

	console.log("=========3, Cls2.prototype是Cls1的实例，有name属性，则结束=========");
	Cls2.prototype = new Cls1(); //Cls3.prototype.__proto__指向Cls1.prototype, , Cls2.prototype是Cls1的实例

	function Cls3() {
		this.say = function() {
			console.log("儿子, 你好");
		}
	}

	console.log("=========2, Cls3.prototype是Cls2的实例, Cls2依然没有name属性，则沿着原型链__proto__向上追溯Cls1.prototype=========");
	console.log("=========Cls2的实例属性__proto__指向Cls1.prototype=========");
	Cls3.prototype = new Cls2(); 

	var obj = new Cls3();
	console.dir(obj);
	obj.say();
	console.log("=========1, obj没有name属性，则沿着原型链__proto__向上追溯Cls3.prototype=========");
	console.log("=========obj.__proto__指向Cls3.prototype=========");
	console.log(obj.name);

	console.log("=========address不存在，则沿原型链__proto__向上追溯父辈是否存在，都不存在，报undefined=========");
	console.log(obj.address); //undefined

	/* console.log("=========实例对象(普通对象)的构造函数(函数对象)属性constructor指向此构造函数=========");
	 console.log("=========__proto__指向它的构造函数的prototype对象，prototype也是此构造函数的一个实例=========");
	 var num = 1;
	 console.log(num.__proto__ == Number.prototype) //true
	 console.log(Number.prototype.constructor == Number) //true, 实例的构造函数属性constructor指向构造函数
	 console.log(num.__proto__.constructor == Number) //true
	 console.log(num.constructor == Number) //true, 实例的构造函数属性constructor指向构造函数

	 function func1(){}
	 var f = new func1;
	 console.log(f.__proto__ == func1.prototype) //true
	 console.log(func1.prototype.constructor == func1) //true
	 console.log(f.__proto__.constructor == func1) //true
	 console.log(f.constructor == func1) //true

	 console.log("=========同一个构造函数创建的实例，constructor相同=========");
	 var f2 = new func1();
	 console.log(f.constructor == f2.constructor) //true

	 console.log("=========函数对象的__proto__仍是函数对象，指向Function.prototype=========");
	 console.log(Number.__proto__ == Number.prototype) //false, __proto__是fuction对象, prototype是Number的实例对象
	 console.log(Number.prototype.constructor == Number) //true
	 console.log(Number.__proto__.constructor == Number) //false, Function != Number
	 console.log(Number.constructor == Number) //false, Function != Number

	 console.log("=========Function.prototype是原型链向上追溯的终结=========");
	 console.log("=========Function.__proto__和Function.prototype都指Function自己=========");
	 console.log(Function.__proto__ == Function.prototype) //true
	 console.log(Function.prototype.constructor == Function) //true
	 console.log(Function.__proto__.constructor == Function) //true
	 console.log(Function.constructor == Function) //true */

	/* 
	 console.log("=========所有对象都有原型属性__proto__, __proto__指向构造它的函数对象的prototype对象=========");
	 console.log("=========普通对象只有原型属性__proto_=========");
	 console.log("=========普通对象的__proto__指向构造它的函数对象的prototype对象=========");
	 var num = 1;
	 console.log(num.__proto__) //Number
	 console.log(typeof num.__proto__) //object
	 console.log(num.__proto__ === Number.prototype) //true
	 console.log(num.prototype) //undefined

	 console.log({}.__proto__) //Object
	 console.log(typeof {}.__proto__) //object
	 console.log({}.__proto__ === Object.prototype) //true
	 console.log({}.prototype) //undefined

	 console.log("=========函数对象有原型属性__proto__和原型属性prototype，只有函数对象有原型属性prototype=========");
	 console.log("=========函数对象的__proto__指向构造它的函数对象(Function)的prototype对象=========");
	 console.log("=========Function.prototype对象是Function的实例对象，Function的实例对象仍然是函数对象=========");
	 function func1(){}
	 console.log(func1.__proto__) //Function
	 console.log(func1.__proto__ === Function.prototype) //true, __proto__指向构造Function.prototype
	 console.log(typeof func1.__proto__) //function, Function的实例对象prototype仍然是函数对象

	 console.log("=========函数对象的prototype是该函数对象的一个实例对象=========");
	 console.log("=========函数对象的__proto__指向构造它的函数对象的prototype对象, prototype为普通对象=========");
	 var f = new func1; //函数对象new得到普通实例对象，普通对象没有prototype
	 console.log(f.__proto__) //Object
	 console.log(typeof f.__proto__) //object, Function的实例对象prototype仍然是函数对象
	 console.log(f.__proto__ === func1.prototype) //true, __proto__指向构造Function.prototype

	 */
	/* 
	 console.log("=========所有对象都有原型属性__proto__, 只有函数对象有原型属性prototype=========");
	 console.log("=========普通对象的原型__proto__也是普通对象=========");
	 console.log("=========普通对象的__proto__指象构造它的函数对象的prototype对象=========");
	 var num = 1;
	 console.log(num.__proto__) //Number
	 console.log(typeof num.__proto__) //object
	 console.log(num.__proto__ === Number.prototype) //true

	 console.log(true.__proto__) //Boolean
	 console.log(typeof true.__proto__) //object

	 console.log("str".__proto__) //String
	 console.log(typeof "str".__proto__) //object

	 console.log([].__proto__) //Array
	 console.log(typeof [].__proto__) //object

	 console.log({}.__proto__) //Object
	 console.log(typeof {}.__proto__) //object

	 console.log("=========普通对象只有原型属性__proto__, 没有原型属性prototype=========");
	 console.log(num.prototype) //undefined
	 console.log([].prototype) //undefined
	 console.log({}.prototype) //undefined 
	 */

	/* 
	
	 console.log("=========函数对象有原型属性__proto__和原型属性prototype=========");
	 console.log("=========函数对象的__proto__是一个函数对象=========");
	 console.log("=========函数对象的prototype是一个普通对象，即该函数对象的一个实例(new)对象=========");
	 console.log("=========普通对象的__proto__指象构造它的函数对象的prototype对象=========");
	 var func = function(){}
	 console.log(func.__proto__) //Function
	 console.log(typeof func.__proto__) //function
	 console.log(func.__proto__) //function
	 console.log(func.prototype) //Function
	 console.log(typeof func.prototype) //object, 并且是Person的一个实例对象(new func())

	 console.log("=========函数对象new得到普通实例对象，普通对象没有prototype=========");
	 console.log((new func).__proto__) //Function
	 console.log(typeof (new func).__proto__) //function
	 console.log((new func).prototype) //undefined
	 console.log(typeof (new func).prototype) //undefined

	 console.log("=========函数对象Function的__proto__和prototype都是函数对象=========");
	 console.log("=========Function的实例对象仍然是函数对象，所以prototype是函数对象=========");
	 console.log(Function.__proto__) //Function
	 console.log(typeof Function.__proto__) //function
	 console.log(Function.prototype) //Function
	 console.log(typeof Function.prototype) //function
	 */
	/* console.log("=========普通对象的__proto__和__proto__.constructor=========");
	 var num = 1;
	 console.log(num.__proto__.constructor) //Number
	 console.log(typeof num.__proto__.constructor) //object

	 console.log(true.__proto__.constructor) //Boolean
	 console.log(typeof true.__proto__.constructor) //object

	 console.log("str".__proto__.constructor) //String
	 console.log(typeof "str".__proto__.constructor) //object

	 console.log([].__proto__.constructor) //Array
	 console.log(typeof [].__proto__.constructor) //object

	 console.log({}.__proto__.constructor) //Object
	 console.log(typeof {}.__proto__.constructor) //object */

	/* console.log("=========除基本类型null和undefined，所有其它函数对象和普通对象都有constructor属性=========");
	 console.log("=========字面量对象的constructor=========");
	 console.log(true.constructor) //Boolean
	 console.log(typeof true.constructor) //function

	 console.log([].constructor) //Array
	 console.log(typeof [].constructor) //function

	 console.log({}.constructor) //Object
	 console.log(typeof {}.constructor) //function

	 console.log("=========var声明的基本数据类型对象的constructor=========");
	 var num = 1;
	 console.log(num.constructor) //Number
	 console.log(typeof num.constructor) //function

	 var str = "122";
	 console.log(str.constructor) //String
	 console.log(typeof str.constructor) //function

	 console.log("=========函数对象的constructor=========");
	 function func2(){}
	 console.log(func2.constructor) //Function
	 console.log(typeof func2.constructor) //function

	 var Person = function(){}
	 console.log(Person.constructor) //Function
	 console.log(typeof Person.constructor) //function
	 console.log((new Person).constructor) //指向Person本身
	 console.log(typeof (new Person).constructor) //function

	 console.log("=========内置函数对象的constructor=========");
	 console.log("=========内置对象FunctoinObject, Array, String, Number, Date等的constructor都是Functoin=========");
	 console.log("=========Functoin的constructor是它自己的。JS里，所有对象的祖先都是Function=========");
	 console.log(Function.constructor) //Function
	 console.log(typeof Function.constructor) //function

	 console.log(Object.constructor) //Function
	 console.log(typeof Object.constructor) //function

	 console.log(Number.constructor) //Function
	 console.log(typeof Number.constructor) //function

	 console.log("=========基本类型null和undefined没有constructor=========");
	 var nl = null;
	 console.log(nl.constructor)
	 console.log(typeof nl.constructor)

	 var udf = undefined;
	 console.log(udf.constructor)
	 console.log(typeof udf.constructor) */

	/* console.log("=========普通对象: 字面量声明的变量=========");
	 console.log("=========基本数据类型:null, undefined, boolean, number, string。都是普通对象=========");
	 console.log(typeof null); //object
	 console.log(typeof undefined); //object
	 console.log(typeof 1); //number
	 console.log(typeof false); //boolean
	 console.log(typeof "abc"); //string
	 console.log(typeof []); //object
	 console.log(typeof {}); //object

	 console.log("=========普通对象: new产生的对象=========");
	 console.log(typeof new Date()); //object
	 console.log(typeof new Array()); //object
	 console.log(typeof new Boolean()); //object
	 console.log(typeof new String()); //object
	 console.log(typeof new function(){}); //object, 从一个函数对象new得到一个普通对象

	 console.log("=========函数对象: 声明的函数，内置函数对象，或者new Function对象=========");
	 console.log(typeof func1); //undefined, 代码段预编译时，赋值式函数已提出来，但还未赋值
	 console.log(typeof func2); //function, 代码段预编译时，声明式函数已经提取出来
	 var func1 = function(){}
	 function func2(){}
	 console.log(typeof func1); //function
	 console.log(typeof func2); //function
	 console.log(typeof function(){}); //function
	 console.log(typeof Function); //function
	 console.log(typeof new Function); //function

	 console.log("=========JS里，有多个内置函数对象Function, Object, Array, String, Number, Date等=========");
	 console.log(typeof Function); //function
	 console.log(typeof Object); //function
	 console.log(typeof Array); //function
	 console.log(typeof String); //function
	 console.log(typeof Number); //function
	 console.log(typeof Boolean); //function
	 console.log(typeof Date); //function

	 console.log("=========函数对象即为构造函数constructor, 可以new得到普通对象=========");
	 console.log(typeof new func1); //object， 函数对象可以new得到普通对象
	 console.log(typeof new func2); //object

	 console.log("=========普通对象new时，代码执行出错=========");
	 var var1 = null;
	 var obj1 = new var1(); //普通对象new时，代码执行出错, Chrome提示"Uncaught TypeError: var1 is not a constructor" */
</script>

<script type="text/javascript">
	/* //JS的解析过程分为两个阶段：预编译期(预处理)与执行期
	
	//预编译期，会提取当前代码块中的声明式函数(function func(){})
	//提前调用执行函数func()并不会报错
	//同时后声明的函数将会覆盖先声明的同名函数, 输出"声明式函数2"
	func();
	
	//预编译期，会提取当前代码块中的声明(var)的变量，但并未赋值
	//提前使用变量并不会出错，但会输出undefined
	console.log(str); 
	
	//预编译期，不会提取当前代码块中的未用var声明的变量
	//提前使用变量会出错
	//console.log(message);
	
	function func() { //声明式函数
		console.log("声明式函数1");
	}

	function func() { //声明式函数
		console.log("声明式函数2");
	}
	
	//预编译期，赋值式函数并不会提取，不会覆盖先前声明的同名函数
	var func = function(){ //赋值式函数
		console.log("赋值式函数3");
	};

	//执行期，赋值式函数将会被执行，并覆盖先前同名的声明式函数
	func();
	
	var str = "声明了一个变量";
	message="未用var声明变量";

	//执行期，var声明的变量将执行赋值动作
	//此明，会输出"声明了一个变量"
	console.log(str);  */
</script>

<script type="text/javascript">
	//js代码分块预编译和执行
	//当前代码段出错，只影响当前代码段的其它代码执行，并不影响另一块代码段的执行
	
	/* console.log(str);//因为没有定义str，所以下面的代码不会执行
	console.log("我是代码块一");//没有运行到这里
	var str1 = "我是代码块一变量"; */
</script>
<script type="text/javascript">
	/* console.log(str1); //输出undefined
	console.log("我是代码块二"); 
	var str2 = "我是代码块二变量"; */
</script>
<script type="text/javascript">
	/* console.log("我是代码块三");
	
	//下一块代码段可以共享上一块代码的变量和方法
	console.log(str2); //输出"我是代码块二变量" */
</script>
<body>
	<button id="test3">test3</button>
	<pre>
<code>
&ltscript&gt
//js代码分块预编译和执行；当前代码段出错，只影响当前代码段的其它代码执行，并不影响另一块代码段的执行
console.log(str);//因为没有定义str，所以下面的代码不会执行
console.log("我是代码块一");//没有运行到这里
var str1 = "我是代码块一变量";
&lt/script&gt
&ltscript&gt
console.log(str1); //输出undefined
console.log("我是代码块二"); //第一个代码段出错，并不影响当前代码的执行
var str2 = "我是代码块二变量";
&lt/script&gt
&ltscript&gt
console.log("我是代码块三"); 
//下一块代码段可以共享上一块代码的变量和方法
console.log(str2); //输出"我是代码块二变量"
&lt/script&gt
<!-- //例9
document.getElementById("test3").onclick = function() {
	var __self = this;
	function fn() {
		console.log(__self == this);
		console.log(__self);
		console.log(this);
	}

	fn();
};  -->
<!-- //例8
function Cls(){
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
 -->
<!-- //例7
function Cls(){
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
console.log(Cls==obj); //Cls==obj -->
<!-- //例6
var objA = {
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
f(); //this指向当前调用对象window -->
<!-- //例5
var objA = {
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
objA.objB.func(); //直接调用对象是objB -->
<!-- //例4
var objA = {
	msg: "objA的msg属性", 
	objB: {
		msg: "objB的msg属性",
		func: function(){
			console.log(this.msg); //objB的msg属性
		    console.log(this); //this==objB
		}
	}
}

objA.objB.func(); -->

<!-- //例3
var obj = {
	msg: "obj调用了func",
	func: function(){
		console.log(this.msg); //obj调用了func
	    console.log(this); //this==obj
	}
}

window.obj.func(); -->

<!-- //例2
var obj = {
	msg: "obj调用了func",
	func: function(){
		console.log(this.msg); //obj调用了func
	    console.log(this); //this==obj
	}
}

obj.func(); -->
<!-- //例1
function func(){
	var msg = "window调用了func";
	console.log(this.msg); //undefined
	console.log(this); //this==window
}

func(); //window.func(); 默认被window对象调用 -->
</code>
</pre>
	<!-- test -->
</body>
</html>

<script>
/* document.getElementById("test3").onclick = function (){
		console.log(this);
		function b(){
			console.log(123);
			console.log(this);
		}
		b();
	} */
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


