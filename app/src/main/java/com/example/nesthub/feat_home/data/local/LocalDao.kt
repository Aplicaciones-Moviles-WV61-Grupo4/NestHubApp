package com.example.nesthub.feat_home.data.local

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query

@Dao
interface LocalDao {
    @Insert
    suspend fun insert(localEntity: LocalEntity)

    @Delete
    suspend fun delete(localEntity: LocalEntity)

    @Query("select * from locales")
    suspend fun fetchAll(): List<LocalEntity>

    @Query("select * from locales where id= :id ")
    suspend fun fetchById(id: String): LocalEntity?
}