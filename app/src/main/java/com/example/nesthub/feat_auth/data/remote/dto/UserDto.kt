package com.example.nesthub.feat_auth.data.remote.dto

import com.example.nesthub.feat_auth.domain.model.User
import com.google.gson.annotations.SerializedName

data class UserDto(
    @SerializedName("id")
    val id: Int,
    @SerializedName("username")
    val username: String,
    @SerializedName("password")
    val password: String
)

fun UserDto.toUser(): User {
    return User(username)
}