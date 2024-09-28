package com.example.nesthub.feat_home.data.local

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "locales")
data class LocalEntity(
    @PrimaryKey
    val id: String,
    @ColumnInfo("type_local")
    val typeLocal: String,
    @ColumnInfo("price_night")
    val priceNight: String,
    @ColumnInfo("photo_url_link")
    val url: String
)