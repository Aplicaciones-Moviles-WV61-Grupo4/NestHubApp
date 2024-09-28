package com.example.nesthub.presentation

import android.icu.text.SimpleDateFormat
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.IntrinsicSize
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.DateRangePicker
import androidx.compose.material3.DisplayMode
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Slider
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TimeInput
import androidx.compose.material3.TimePicker
import androidx.compose.material3.TimePickerState
import androidx.compose.material3.rememberDateRangePickerState
import androidx.compose.material3.rememberTimePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.window.Dialog
import androidx.compose.ui.window.DialogProperties
import com.example.nesthub.R
import java.util.Calendar
import java.util.Date
import java.util.Locale

//ScreenPrincipal de Payment
@Composable
fun PaymentScreen() {
    Scaffold { paddingValues ->
        LazyColumn(
            modifier = Modifier
                .padding(paddingValues)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            item {
                Text(
                    text = "Confirma y paga",
                    fontSize = 24.sp,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(bottom = 16.dp)
                )
            }

            item {
                PropertyCardComponent()
                HorizontalDivider(modifier = Modifier.width(353.dp).padding(vertical = 8.dp))
            }

            item {
                TravelComponent()
                HorizontalDivider(modifier = Modifier.width(353.dp).padding(vertical = 8.dp))
            }

            item {
                InformationPriceComponent()
                HorizontalDivider(modifier = Modifier.width(353.dp).padding(vertical = 8.dp))
            }

            item {
                PaymentMethodComponent()
                HorizontalDivider(modifier = Modifier.width(353.dp).padding(vertical = 8.dp))
            }

            item {
                RequiredComponent()
                HorizontalDivider(modifier = Modifier.width(353.dp).padding(vertical = 8.dp))
            }

            item {
                CancelationPoliticsComponent()
                HorizontalDivider(modifier = Modifier.width(353.dp).padding(vertical = 8.dp))
            }

            item {
                ConfirmationButtonComponent()
            }
        }
    }
}

//Debe recibir los datos del PaymentViewModel
//Cambiar parametros por los de View Model
@Composable
fun PropertyCardComponent(){
    Card(
        colors = CardDefaults.cardColors(
            containerColor = Color.White,
            contentColor = Color.Black
        ),
        modifier = Modifier.fillMaxWidth()
    ) {
        Row {
            Image(
                painter = painterResource(id = R.drawable.image_77),
                contentDescription = "Description",
                alignment = Alignment.Center,
                contentScale = ContentScale.FillBounds,
                modifier = Modifier
                    .size(200.dp)
                    .clip(RoundedCornerShape(16.dp))
            )

            Column {
                Text(
                    modifier = Modifier.padding(
                        top = 16.dp,
                        start = 8.dp
                    ),
                    text = "Vivienda rentada entero",
                    fontSize = 12.sp
                )
                Text(
                    modifier = Modifier.padding(
                        top = 4.dp,
                        start = 8.dp
                    ),
                    text = "Loft en Barranco",
                    fontSize = 13.sp
                )

                Row(
                    modifier = Modifier.padding(
                        top = 48.dp,
                        start = 8.dp
                    )
                ) {
                    Image(
                        painter = painterResource(id = R.drawable.image_80),
                        contentDescription = "Icon_Rating",
                        modifier = Modifier
                            .size(11.dp)
                    )
                    Text(
                        text = "4.92(10)",
                        fontSize = 13.sp,
                        modifier = Modifier.padding(
                            start = 2.dp
                        ),

                        )
                }

            }
        }
    }
}

//Debe recibir los datos del PaymentViewModel; falta definir
//Cambiar parametros por los de View Model
@Composable
fun TravelComponent() {
    var showDatePicker by remember { mutableStateOf(false) }
    var selectedDateRange by remember { mutableStateOf<Pair<Long?, Long?>>(null to null) }
    var showTimeRangePicker by remember { mutableStateOf(false) }
    var selectedStartTime by remember { mutableStateOf("") }
    var selectedEndTime by remember { mutableStateOf("") }
    var showGuestCountDialog by remember { mutableStateOf(false) }
    var guestCount by remember { mutableStateOf(1) }

    Column {
        Row(
            modifier = Modifier.padding(top = 8.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = "Tu viaje",
                    fontSize = 16.sp
                )
                Text(
                    text = "Fechas",
                    fontSize = 13.sp,
                    modifier = Modifier.padding(top = 8.dp)
                )

                if (selectedDateRange.first != null && selectedDateRange.second != null) {
                    val startDate = SimpleDateFormat("MMM dd, yyyy", Locale.getDefault()).format(Date(selectedDateRange.first!!))
                    val endDate = SimpleDateFormat("MMM dd, yyyy", Locale.getDefault()).format(Date(selectedDateRange.second!!))
                    Text(
                        text ="$startDate - $endDate",
                        fontSize = 11.sp
                    )
                } else {
                    Text("       ,    ")
                }
            }
            EditButton(onClick = { showDatePicker = true })
        }

        Row(
            modifier = Modifier.padding(top = 8.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = "Hora de llegada",
                    fontSize = 13.sp,
                )

                if (selectedStartTime.isNotEmpty() && selectedEndTime.isNotEmpty()) {
                    Text(
                        text = "$selectedStartTime - $selectedEndTime",
                        fontSize = 11.sp)
                } else {
                    Text(
                        text = " - ",
                        fontSize = 11.sp)
                }
            }
            EditButton(onClick = { showTimeRangePicker = true })
        }

        Row(
            modifier = Modifier.padding(top = 8.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = "Huespedes",
                    fontSize = 13.sp,
                )

                Text(
                    text ="$guestCount huéspedes",
                    fontSize = 11.sp
                )
            }
            EditButton(onClick = { showGuestCountDialog = true })
        }
    }

    if (showDatePicker) {
        DateRangePickerScreen(
            onDismiss = { showDatePicker = false },
            onDateRangeSelected = {
                selectedDateRange = it
                showDatePicker = false
            }
        )
    }

    if (showTimeRangePicker) {
        MyTimeRangePickerScreen(
            onConfirm = { startTime, endTime ->
                selectedStartTime = startTime
                selectedEndTime = endTime
                showTimeRangePicker = false
            },
            onDismiss = { showTimeRangePicker = false }
        )
    }

    if (showGuestCountDialog) {
        GuestCountDialog(
            currentGuestCount = guestCount,
            onGuestCountChange = { newCount -> guestCount = newCount },
            onDismiss = { showGuestCountDialog = false }
        )
    }
}

//Debe recibir los datos del PaymentViewModel
//Cambiar parametros por los de View Model
@Composable
fun InformationPriceComponent() {
    Column(
        modifier = Modifier.fillMaxWidth()
    ) {
        Row(
            modifier = Modifier.padding(top = 8.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(
                modifier = Modifier.weight(1F)
            ) {
                Text(
                    text = "Información del precio",
                    fontSize = 16.sp
                )
                Row(
                    modifier = Modifier.padding(top = 16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "$35.88 x 8 noches",
                        fontSize = 11.sp
                    )
                    Spacer(modifier = Modifier.weight(1f))
                    Text(
                        text = "$287.00",
                        fontSize = 11.sp
                    )
                }

                Row(
                    modifier = Modifier.padding(top = 16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "Descuentos",
                        fontSize = 11.sp
                    )
                    Spacer(modifier = Modifier.weight(1f))
                    Text(
                        text = "$0.0",
                        fontSize = 11.sp
                    )
                }

                Row(
                    modifier = Modifier.padding(top = 16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "Tarifa de limpieza",
                        fontSize = 11.sp
                    )
                    Spacer(modifier = Modifier.weight(1f))
                    Text(
                        text = "XXX.X",
                        fontSize = 11.sp
                    )
                }

                Box(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 16.dp, bottom = 8.dp),
                    contentAlignment = Alignment.Center
                ) {
                    HorizontalDivider(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(horizontal = 16.dp),
                        thickness = 1.dp,
                        color = Color.Gray
                    )
                }

                Row(
                    modifier = Modifier.padding(top = 16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "Total",
                        fontSize = 11.sp
                    )
                    Spacer(modifier = Modifier.weight(1f))
                    Text(
                        text = "317.00",
                        fontSize = 11.sp
                    )
                }
            }
        }
    }
}

//Conexion pasarela de pagos
@Composable
fun PaymentMethodComponent(){
    Column(
        modifier = Modifier.fillMaxWidth()
    ) {
        Text(
            text = "Paga Con",
            fontSize = 16.sp
        )

        Row (
            modifier = Modifier.padding(top = 8.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ){
            Icon(
                painter = painterResource(id = R.drawable.pay),
                contentDescription = "Payment_Icon"
            )

            Text(
                text = "Tarjeta de credito o débito",
                fontSize = 11.sp,
                modifier = Modifier.padding(start = 8.dp)
            )
        }

        Row(
            modifier = Modifier.padding(top = 8.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Icon(
                painter = painterResource(id = R.drawable.pay),
                contentDescription = "Payment_Icon"
            )

            Text(
                text = "Paypal",
                fontSize = 11.sp,
                modifier = Modifier.padding(start = 8.dp)
            )
        }


    }
}

//Debe recibir los datos del PaymentViewModel; por definir
//Cambiar parametros por los de View Model
@Composable
fun RequiredComponent() {
    Column(
        modifier = Modifier.fillMaxWidth()
    ) {
        Text(
            text = "Requerido",
            fontSize = 16.sp
        )

        Row(
            modifier = Modifier.padding(top = 2.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text(
                text = "Número de teléfono"
            )
            Spacer(modifier = Modifier.weight(1f))
            OutlinedButton(
                onClick = { },
                colors = ButtonDefaults.buttonColors(
                    contentColor = colorResource(id = R.color.orange),
                    containerColor = Color.Transparent
                ),
                border = BorderStroke(1.dp, color = colorResource(id = R.color.orange)),
                shape = RoundedCornerShape(50),
                modifier = Modifier
                    .padding(top = 16.dp)
            ) {
                Text(text = "Agregar")
            }
        }

        Row(
            modifier = Modifier.padding(top = 2.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column {
                Text(
                    text = "Agrega y confirma tu número de teléfono",
                    modifier = Modifier.padding(top = 8.dp)
                )

                Text(
                    text = "para recibir actualizaciones del viaje",
                    modifier = Modifier.padding(top = 4.dp)
                )
            }
        }
    }
}

//Debe recibir los datos del PaymentViewModel
//Fecha Variable
//Cambiar parametros por los de View Model
@Composable
fun CancelationPoliticsComponent(){
    Column {
        Text(
            text = "Política de cancelación",
            fontSize = 16.sp
        )

        Text(
            text = "Si cancelas antes del 15 de sept. recibirás un rembolzo completo",
            fontSize = 13.sp,
            modifier = Modifier.padding(top = 8.dp)
        )
    }
}

@Composable
fun ConfirmationButtonComponent(){
    Button(
        onClick = { },
        colors = ButtonDefaults.buttonColors(
            containerColor = colorResource(id = R.color.yellow),
            contentColor = Color.White
        ),
        modifier = Modifier
            .width(325.dp)
            .height(47.dp),
        shape = RoundedCornerShape(50)
    ) {
        Text(
            text = "Confirma y paga",
            fontSize = 15.sp,
            textAlign = TextAlign.Center
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DateRangePickerModalInput(
    onDateRangeSelected: (Pair<Long?, Long?>) -> Unit,
    onDismiss: () -> Unit
) {
    val dateRangePickerState = rememberDateRangePickerState(
        initialDisplayMode = DisplayMode.Input
    )

    DatePickerDialog(
        onDismissRequest = onDismiss,
        confirmButton = {
            TextButton(onClick = {
                onDateRangeSelected(
                    Pair(
                        dateRangePickerState.selectedStartDateMillis,
                        dateRangePickerState.selectedEndDateMillis
                    )
                )
                onDismiss()
            }) {
                Text("OK")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel")
            }
        }
    ) {
        DateRangePicker(state = dateRangePickerState)
    }
}

@Composable
fun DateRangePickerScreen(
    onDismiss: () -> Unit,
    onDateRangeSelected: (Pair<Long?, Long?>) -> Unit
) {
    var showModal by remember { mutableStateOf(true) }

    if (showModal) {
        DateRangePickerModalInput(
            onDateRangeSelected = {
                onDateRangeSelected(it)
                showModal = false
            },
            onDismiss = {
                showModal = false
                onDismiss()
            }
        )
    }
}

@Composable
fun EditButton(onClick: () -> Unit) {
    TextButton(onClick = onClick) {
        Text(
            text ="Editar",
            color = colorResource(id = R.color.blue)
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MyTimeRangePickerScreen(onConfirm: (String, String) -> Unit, onDismiss: () -> Unit) {
    var selectedStartTime by remember { mutableStateOf("") }
    var selectedEndTime by remember { mutableStateOf("") }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        TimeRangePicker(
            onConfirm = { startState, endState ->
                selectedStartTime = String.format("%02d:%02d", startState.hour, startState.minute)
                selectedEndTime = String.format("%02d:%02d", endState.hour, endState.minute)
                onConfirm(selectedStartTime, selectedEndTime)
            },
            onDismiss = {
                onDismiss()
            }
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TimeRangePicker(
    onConfirm: (TimePickerState, TimePickerState) -> Unit,
    onDismiss: () -> Unit
) {
    val currentTime = Calendar.getInstance()
    val startTimePickerState = rememberTimePickerState(
        initialHour = currentTime.get(Calendar.HOUR_OF_DAY),
        initialMinute = currentTime.get(Calendar.MINUTE),
        is24Hour = true,
    )
    val endTimePickerState = rememberTimePickerState(
        initialHour = currentTime.get(Calendar.HOUR_OF_DAY),
        initialMinute = currentTime.get(Calendar.MINUTE),
        is24Hour = true,
    )

    var showDial by remember { mutableStateOf(true) }

    AdvancedTimePickerDialog(
        title = "Seleccionar Rango de Tiempo",
        onDismiss = onDismiss,
        onConfirm = {
            onConfirm(startTimePickerState, endTimePickerState)
        },
        toggle = {
            IconButton(onClick = { showDial = !showDial }) {
                Icon(
                    imageVector = if (showDial) Icons.Filled.Edit else Icons.Filled.DateRange,
                    contentDescription = "Alternar tipo de selector de tiempo",
                )
            }
        },
    ) {
        TimePickerContent(startTimePickerState, endTimePickerState, showDial)
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TimePickerContent(startState: TimePickerState, endState: TimePickerState, showDial: Boolean) {
    Column {
        Text("Hora de Inicio")
        if (showDial) {
            TimeInput(state = startState)
        } else {
            TimePicker(state = startState)
        }

        Spacer(modifier = Modifier.height(16.dp))

        Text("Hora de Fin")
        if (showDial) {
            TimeInput(state = endState)
        } else {
            TimePicker(state = endState)
        }
    }
}

@Composable
fun AdvancedTimePickerDialog(
    title: String = "Seleccionar Hora",
    onDismiss: () -> Unit,
    onConfirm: () -> Unit,
    toggle: @Composable () -> Unit = {},
    content: @Composable () -> Unit,
) {
    Dialog(
        onDismissRequest = onDismiss,
        properties = DialogProperties(usePlatformDefaultWidth = false),
    ) {
        Surface(
            shape = MaterialTheme.shapes.extraLarge,
            tonalElevation = 6.dp,
            modifier = Modifier
                .width(IntrinsicSize.Min)
                .height(IntrinsicSize.Min)
                .background(MaterialTheme.colorScheme.surface),
        ) {
            Column(
                modifier = Modifier.padding(24.dp),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Text(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(bottom = 20.dp),
                    text = title,
                    style = MaterialTheme.typography.labelMedium
                )
                content()
                Row(
                    modifier = Modifier
                        .height(40.dp)
                        .fillMaxWidth()
                ) {
                    toggle()
                    Spacer(modifier = Modifier.weight(1f))
                    TextButton(onClick = onDismiss) { Text("Cancelar") }
                    TextButton(onClick = onConfirm) { Text("OK") }
                }
            }
        }
    }
}

@Composable
fun GuestCountDialog(
    currentGuestCount: Int,
    onGuestCountChange: (Int) -> Unit,
    onDismiss: () -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Seleccionar cantidad de huéspedes") },
        text = {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Text("Cantidad de huéspedes: $currentGuestCount")
                Slider(
                    value = currentGuestCount.toFloat(),
                    onValueChange = { value ->
                        onGuestCountChange(value.toInt())
                    },
                    valueRange = 1f..10f, // Rango de 1 a 10 huéspedes
                    steps = 9 // Esto crea 9 pasos entre 1 y 10
                )
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Aceptar")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancelar")
            }
        }
    )
}


@Preview(showBackground = true)
@Composable
fun TimeRangePickerPreview() {
    PaymentScreen()
}