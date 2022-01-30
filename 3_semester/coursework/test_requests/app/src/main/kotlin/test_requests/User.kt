package test_requests

import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.client.engine.cio.*
import kotlinx.coroutines.*
import kotlinx.serialization.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import io.ktor.client.request.forms.*


@Serializable
data class AuthStatus(val status:Int,val token:String)
@Serializable
data class GetIdStatus(val status:Int,val id:Int)

data class User(val login:String, val password:String)

suspend fun Auth(c:HttpClient,user:User):AuthStatus{
    val response: AuthStatus = c.submitForm(
            url = "http://localhost:8080/user/auth",
            formParameters = Parameters.build {
                append("login", user.login)
                append("password", user.password)
            },
            encodeInQuery = false
        )
    return response
}

// suspend fun GetUserId(c:HttpClient,token:String):GetIdStatus{
//     val response: GetIdStatus = c.get("http://127.0.0.1:8080/user/id/get") {
//         headers {
//             append("Authorization", "Bearer "+token)
//         }
        
//     }
//     return response
// }