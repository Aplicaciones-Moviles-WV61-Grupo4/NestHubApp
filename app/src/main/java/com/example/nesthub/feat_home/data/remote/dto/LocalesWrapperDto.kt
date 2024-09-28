package com.example.nesthub.feat_home.data.remote.dto

import com.google.gson.annotations.SerializedName

data class LocalesWrapperDto(
    @SerializedName("response")
    val response: String,
    @SerializedName("error")
    val error: String?,
    @SerializedName("results")
    val locales: List<LocalDto>?
)