package com.example.nesthub.feat_auth.presentation.viewmodel

import com.example.nesthub.feat_auth.domain.model.User

data class SingInState(
    val isLoading: Boolean = false,
    val user: User? = null,
    val error: String = ""
)
