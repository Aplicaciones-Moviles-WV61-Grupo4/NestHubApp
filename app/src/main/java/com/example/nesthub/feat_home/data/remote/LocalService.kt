package com.example.nesthub.feat_home.data.remote

import com.example.nesthub.feat_home.data.remote.dto.LocalesWrapperDto
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path

interface LocalService {

    @GET("api/v1/locals/{type_local}")
    suspend fun searchLocales(@Path("type_local") typeLocal: String): Response<LocalesWrapperDto>
}