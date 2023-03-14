from matrix import add, multiply_by_number, subtract, transpose, multiply


def multiply_by_number_test():
    m = multiply_by_number(
        [
            [1, 2, 3],
            [1, 2, 3],
            [1, 20, 3],
        ], 10 );
    e = [
        [10, 20, 30],
        [10, 20, 30],
        [10, 200, 30],
    ]
    if m != e:
        print("mn: Not equal")

def add_test():
    m1 = add(
        [
            [1, 2, 3, 4],
            [1, 2, 3, 4],
            [1, 2, 3, 4],
        ],
        [
            [1, 2, 3, 4],
            [1, 2, 3, 4],
            [1, 2, 3, 4],
        ]
    ) 
    m2 = [
        [2, 4, 6 ,8],
        [2, 4, 6 ,8],
        [2, 4, 6 ,8],
    ]
    
    if m1 != m2:
        print("add: Not equal")
        print(m1, m2);

def subtract_test():
    m1 = subtract(
        [
            [1, 2, 3, 8],
            [1, 2, 3, 8],
            [1, 2, 3, 4],
        ],
        [
            [1, 2, 3, 4],
            [1, 0, 3, 4],
            [1, 2, 3, 4],
        ]
    ) 
    m2 = [
        [0, 0, 0, 4],
        [0, 2, 0, 4],
        [0, 0, 0, 0],
    ]
    
    if m1 != m2:
        print("subtract: Not equal")
        print(m1, m2);


def transpose_test():
    m1 = transpose(
        [
            [1, 2, 3],
            [4, 5, 6]
        ]
        
    ) 
    m2 = [
        [1, 4],
        [2, 5],
        [3, 6]
    ]
    
    if m1 != m2:
        print("transpose: Not equal")
        print(m1, m2);

def multiply_test():
    m1 = multiply(
        [
            [5, 4],
            [4, 3],
            [3, 2],
            
        ],
        [
            [2, 3, 4, 5],
            [6, 6, 6, 3],
        ]
    ) 
    m2 = [
        [34, 39, 44, 37],
        [26, 30, 34, 29],
        [18, 21, 24, 21],
    ]
    
    if m1 != m2:
        print("multiply: Not equal")
        print(m1, m2);



if __name__ == "__main__":
    multiply_by_number_test()
    add_test()
    subtract_test()
    transpose_test()
    multiply_test()