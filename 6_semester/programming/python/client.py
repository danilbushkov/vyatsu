import xmlrpc.client



if __name__ == "__main__":
    with xmlrpc.client.ServerProxy("http://localhost:8000/") as proxy:

        m1 = [
            [1, 2, 3],
            [1, 2, 3],
            [1, 2, 3],
        ]
        m2 = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
        ]

        print("add: %s" % str(proxy.add(m1, m2)))
        print("substract: %s" % str(proxy.subtract(m1, m2)))
        print("multiply: %s" % str(proxy.multiply(m1, m2)))
        print("multiply_by_number: %s" % str(proxy.multiply_by_number(m1, 10)))
        print("transpose: %s" % str(proxy.transpose(m2)))


