package com.example.nesthub.feat_home.data.local

import androidx.room.Database
import androidx.room.RoomDatabase

@Database(entities = [LocalEntity::class], version = 1)
abstract class AppDatabase  : RoomDatabase(){
    abstract fun localDao(): LocalDao
}