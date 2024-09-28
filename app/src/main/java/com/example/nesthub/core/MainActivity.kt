package com.example.nesthub.core

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import com.example.nesthub.feat_auth.data.remote.LoginService
import com.example.nesthub.feat_auth.data.repository.LoginRepositoryImpl
import com.example.nesthub.feat_auth.domain.use_case.SignInUseCase
import com.example.nesthub.feat_auth.presentation.ui.LoginScreen
import com.example.nesthub.feat_auth.presentation.viewmodel.SignInViewModel
import com.example.nesthub.ui.theme.NestHubTheme
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class MainActivity : ComponentActivity() {
    private val service = Retrofit.Builder()
        .baseUrl(ApiClient.BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
        .create(LoginService::class.java)

    private val repository = LoginRepositoryImpl(service)
    private val useCase = SignInUseCase(repository)
    private val viewModel = SignInViewModel(useCase)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            NestHubTheme {
                LoginScreen()
            }
        }
    }
}


