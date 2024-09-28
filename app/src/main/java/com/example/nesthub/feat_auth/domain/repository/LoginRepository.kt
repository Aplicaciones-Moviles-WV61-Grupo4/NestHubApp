package com.example.nesthub.feat_auth.domain.repository

import com.example.nesthub.feat_auth.data.remote.dto.UserDto;


interface LoginRepository {

    fun signIn(username: String, password: String,  callback: (List<UserDto>) -> Unit)

    fun signUp(username: String, password: String)
}