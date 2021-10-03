package lab1

import kotlin.math.*

val function="ln(1+2x)-2+x"

fun Func(x: Double) : Double             = ln(1+2*x)-2+x
fun FirstDerivative(x: Double) : Double  = (2/(1+2*x)) + 1
fun SecondDerivative(x: Double) : Double = -4/((2*x+1).pow(2))
fun Hord(a:Double, b:Double, f: (Double)->Double):Double =
        b - f(b) * (b-a)/(f(b)-f(a))

fun isolate(a:Double, _left:Double, _right:Double, func: (Double)->Double)
: Array<Double>{
    var left: Double = _left
    var right: Double = _right
    var arr: Array<Double> = arrayOf(0.0,0.0)
    while(func(left + a) * func(right-a)<0){
        left+=a
        right-=a
    }
    while(func(left) * func(left+a)>0){
        left+=a
    }
    while(func(right) * func(right-a)>0){
        right-=a
    }
    arr[0]=left
    arr[1]=right
    return arr;
}

fun com_m(l:Double,
          r:Double,
          eps:Double,
          Func: (Double)->Double,
          D1: (Double)->Double,
          D2: (Double)->Double
          ): MutableList<Array<Double>>
{
    var f = Func(l) * D2(l) > 0
    var a: Double
    var b: Double
    var d: Double
    var i: Int = 0
    var arr = mutableListOf<Array<Double>>();
    if(f){
        b=l
        a=r
    }else{
        b=r
        a=l
    }
    do{
        i++
        d=b-a
        if(f){
            b = Hord(a,b,::Func)
            a = a - Func(a)/D1(a)
        } else {
            a = Hord(a,b,::Func)
            b = b - Func(b)/D1(b)
        }
        arr.add(arrayOf(a,b))

    }while (abs(d)>eps)
    return  arr
}

fun main() {
    var arr: Array<Double> = isolate(0.01,0.5,1.4, ::Func)
    //println("%.3f %.3f\n".format(arr[0],arr[1]));
    var ml = com_m(0.5,1.4, 0.00001,::Func,::FirstDerivative,::SecondDerivative)
    for(ar in ml){
        for(a in ar){
            print("%.6f ".format(a))
        }
        println("\n")
    }
}