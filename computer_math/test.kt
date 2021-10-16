package lab1

import kotlin.math.*

val function="ln(1+2x)-2+x"

fun Func(x: Double) : Double             = ln(1+2*x)-2+x
fun FirstDerivative(x: Double) : Double  = (2/(1+2*x)) + 1
fun SecondDerivative(x: Double) : Double = -4/((2*x+1).pow(2))
fun Hord(a:Double, b:Double, f: (Double)->Double):Double =
        b - f(b) * (b-a)/(f(b)-f(a))

fun Canon(x: Double) : Double = 2 - ln(1+2*x)
fun CanonDerivative(x: Double) : Double{
    var k=2.0
    
    return (-1*FirstDerivative(x)/k)
}

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

fun iter_m(
    l:Double,
    r:Double,
    eps:Double,
    Func: (Double)->Double,
    D1: (Double)->Double
          
): MutableList<Array<Double>>
{
    var a:Double = l
    var d:Double
    var b:Double = 0.0
    var k:Double
    var arr = mutableListOf<Array<Double>>()
    var q:Double

    k = max(FirstDerivative(0.5),FirstDerivative(1.4))
    //println(k)
    do{
        b = a
        a = a - Func(a)/k
        d = abs(a - b) 

        arr.add(arrayOf(b,a,d))
    //d>eps   
    }while( d > eps)
    return  arr
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
    var a1:Double
    var b1:Double
    var arr = mutableListOf<Array<Double>>()
    if(f){
        b=l
        a=r
    }else{
        b=r
        a=l
    }
    do{
        a1=a
        b1=b

        if(f){
            b = Hord(a,b,::Func)
            a = a - Func(a)/D1(a)
        } else {
            a = Hord(a,b,::Func)
            b = b - Func(b)/D1(b)
        }
        d=abs(b-a)
        arr.add(arrayOf(a1,b1,a,b,d))
        
    }while (d>eps)
    return  arr
}

fun main() {
    //var arr: Array<Double> = isolate(0.01,0.5,1.4, ::Func)
    //println("%.3f %.3f\n".format(arr[0],arr[1]));
    var ml1 = com_m(0.5,1.4, 0.00001,::Func,::FirstDerivative,::SecondDerivative)
    var ml = iter_m(0.5,1.4, 0.00001,::Func,::FirstDerivative)
    var i:Int=0
    var res:Double=0.0;
    var j:Int=0
    println("Function: " + function)
    println("[0,5; 1,4]")
    print("Phi'(a) = " + FirstDerivative(0.5))
    println(" Phi'(b) = " + FirstDerivative(1.4))
    
    if(CanonDerivative(0.5)<0.0){
        println("Two-way convergence -> |xn+1 - xn| <= eps")
    }else{
        println("Monotonic convergence -> (1/(1-q))*|xn+1 - xn|")
    }

    println("Combined method:")
    if(Func(0.5) * SecondDerivative(0.5) > 0){
        println("Excess - Chord method")
        println("Flaw - Tanget method")
    }else{
        println("Excess - Tanget method")
        println("Flaw - Chord method")
    }
    println("f(a) = " + Func(0.5))
    println("f(b) = " + Func(1.4))
    println("f'(a) = " + FirstDerivative(0.5))
    println("f'(b) = " + FirstDerivative(1.4))
    println("f''(a) = " + SecondDerivative(0.5))
    println("f''(b) = " + SecondDerivative(1.4))
    println("xa                xb          f(xa)       f(xb)      |f(xa)-f(xb)|")

    for(ar in ml1){
        print(i.toString() + " ")
        j=0
        for(a in ar){
            print("%.6f      ".format(a))
            j++
            if(j==4){
                res=a
            }
        }
        println()
        i++
    }
    println("Result = "+res)
    println()
    i=0
    
    println("Iteration method:")
    println("phi'(a) = " + CanonDerivative(0.5))
    println("phi'(b) = " + CanonDerivative(1.4))
    println("n       Xn      Xn+1       |Xn-Xn+1|")
    for(ar in ml){
        print(i.toString()+" ")
        for(a in ar){
            print("%.6f ".format(a))
            j++
            if(j==4){
                res=a
            }
        }
        println()
        
        i++
    }
    println("Result = "+res)

}