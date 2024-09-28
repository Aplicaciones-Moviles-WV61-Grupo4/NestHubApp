package com.example.nesthub.feat_home.data.remote.dto

import com.example.nesthub.feat_home.domain.Local
import com.google.gson.annotations.SerializedName

data class LocalDto(
    @SerializedName("id")
    val id: String,
    @SerializedName("type_local")
    val typeLocal: String,
    @SerializedName("price_night")
    val priceNight: String,
    @SerializedName("address_district")
    val addressDistrict: String,
    @SerializedName("photo_url_link")
    val url: String
)

fun LocalDto.toLocal(): Local {
    return Local(id, typeLocal, priceNight, addressDistrict, url)
}