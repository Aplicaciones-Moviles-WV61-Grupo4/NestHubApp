package com.example.nesthub.presentation

import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import androidx.navigation.compose.rememberNavController

import com.example.nesthub.R

//
@Composable
fun BottomNavigationBar(navController: NavController? = null) {
    NavigationBar {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(4.dp),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            val items = listOf(
                "Explora" to R.drawable.search,
                "Favoritos" to R.drawable.fav,
                "Mensajes" to R.drawable.message,
                "Perfil" to R.drawable.profile
            )
            items.forEach { (title, iconRes) ->
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    modifier = Modifier.weight(1f).clickable {
                        navController?.navigate(title)
                    }
                ) {
                    Image(
                        painter = painterResource(id = iconRes),
                        contentDescription = "Icono_$title",
                        modifier = Modifier.size(41.dp).padding(bottom = 4.dp)
                    )
                    Text(
                        modifier = Modifier.padding(top = 4.dp),
                        text = title,
                        fontSize = 13.sp,
                        textAlign = TextAlign.Center
                    )
                }
            }
        }
    }
}

@Composable
fun OptionsIconsRow() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(4.dp),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        val items = listOf(
            "Destacados" to R.drawable.image,
            "Salones" to R.drawable.image_84,
            "Casa de playas" to R.drawable.rectangle_64,
            "Casas urbanas" to R.drawable.image_83,
            "Casas de campo" to R.drawable.image_85
        )
        items.forEach { (title, iconRes) ->
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier.weight(1f)
            ) {
                Image(
                    painter = painterResource(id = iconRes),
                    contentDescription = "Icono_$title",
                    modifier = Modifier.size(61.dp).padding(bottom = 4.dp)
                )
                Text(
                    modifier = Modifier.padding(top = 4.dp),
                    text = title,
                    fontSize = 13.sp,
                    textAlign = TextAlign.Center
                )
            }
        }
    }
}


@Composable
fun SearchBar(value: String, onValueChange: (String) -> Unit) {
    OutlinedTextField(
        value = value,
        onValueChange = onValueChange,
        modifier = Modifier
            .fillMaxWidth()
            .padding(bottom = 16.dp),
        leadingIcon = {
            Image(
                painter = painterResource(id = R.drawable.image_19),
                contentDescription = "Icono_Busqueda",
                modifier = Modifier.size(35.dp)
            )
        },
        shape = RoundedCornerShape(24.dp),
        colors = OutlinedTextFieldDefaults.colors(
            unfocusedBorderColor = colorResource(R.color.green)
        )
    )
}

//Screen Principal; llamada en main activity; definir navController
@Composable
fun HomeScreen(navController: NavController? = null) {
    Scaffold(
        bottomBar = {   }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .padding(16.dp)
        ) {
            SearchBar(value = "Usuario", onValueChange = {})
            OptionsIconsRow()
            HomeListScreen()
        }
    }
}

@Preview(showBackground = true)
@Composable
fun HomeScreenPreview() {
    val navController = rememberNavController()
    HomeScreen(navController)
}
