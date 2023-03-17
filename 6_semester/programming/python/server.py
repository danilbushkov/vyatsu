from xmlrpc.server import SimpleXMLRPCServer
from matrix.matrix import subtract, add, multiply, multiply_by_number, transpose


if __name__ == "__main__":
    server = SimpleXMLRPCServer(("localhost", 8000))
    print("Listening on port 8000...")
    server.register_function(subtract, "subtract")
    server.register_function(add, "add")
    server.register_function(multiply, "multiply")
    server.register_function(multiply_by_number, "multiply_by_number")
    server.register_function(transpose, "transpose")
    server.serve_forever()