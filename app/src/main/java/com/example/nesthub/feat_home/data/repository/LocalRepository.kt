package com.example.nesthub.feat_home.data.repository

import com.example.nesthub.core.Resource
import com.example.nesthub.feat_home.data.remote.LocalService
import com.example.nesthub.feat_home.data.remote.dto.LocalDto
import com.example.nesthub.feat_home.data.remote.dto.toLocal
import com.example.nesthub.feat_home.domain.Local
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class LocalRepository (

    private val localService: LocalService

) {
    suspend fun searchLocales(typeLocal:String): Resource<List<Local>> = withContext(Dispatchers.IO) {
        val response = localService.searchLocales(typeLocal)
        if (response.isSuccessful){
            response.body()?.locales?.let {localesDto ->
                val locales = mutableListOf<Local>()

                localesDto.forEach{ localDto: LocalDto ->
                    val local =localDto.toLocal()
                    locales += local
                }
                return@withContext Resource.Success(data = locales.toList())

            }
            return@withContext Resource.Error(
                message = response.body()?.error ?: "An error ocurred"
            )

        }else{
            return@withContext Resource.Error(message = response.message())
        }
    }

}