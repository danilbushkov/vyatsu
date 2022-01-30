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


// @Serializable
// data class AuthStatus(val status:Int,val token:String)
// data class User(val login:String, val password:String)




// suspend fun GetTasks(c:HttpClient,user:User):AuthStatus{
//     val response: AuthStatus = c.submitForm(
//             url = "http://localhost:8080/auth",
//             formParameters = Parameters.build {
//                 append("login", user.login)
//                 append("password", user.password)
//             },
//             encodeInQuery = false
//         )
//     return response
// }