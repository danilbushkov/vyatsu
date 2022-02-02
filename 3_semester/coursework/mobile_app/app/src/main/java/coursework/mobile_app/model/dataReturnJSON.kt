package coursework.mobile_app.model

import kotlinx.serialization.Serializable


@Serializable
data class Status(val status:Int)
@Serializable
data class AuthStatus(val status: Int,val token:String)
