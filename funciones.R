# Cargar librerías ----

library(data.table)
library(readxl)
library(tidyverse)
library(lubridate)

# Cargar datos ----
# Leer archivos de el directorio data
mis_tablas <- list.files("Data", pattern = "xlsx")

# Nombre de las tablas sin el csv
nombre_tablas <- gsub(".xlsx", "", mis_tablas) %>% 
  gsub('Excel_Activ_FB8_ ', "", .)
# Número de tablas
n_archivos <- length(mis_tablas)

# Ruta del completa de cada archivos
mis_tablas_path <- paste0(getwd(), "/Data/", list.files("Data", pattern = "xlsx"))

# creo una lista con totdas las tablas
lista_de_tablas <- lapply(mis_tablas_path, read_excel)

# lista de tablas con nombre
lista_de_tablas <- magrittr::set_names(lista_de_tablas, nombre_tablas)

# Obtenmeos los dataframe
for (i in names(lista_de_tablas)) {
  assign(paste0("df_", i), lista_de_tablas[[i]])
}


# Comprobamos en el dataframe que variable tiene NA ----
fun_NA_df <- function(dataframe){
  sapply(dataframe, function(x) sum(is.na(x)))
}