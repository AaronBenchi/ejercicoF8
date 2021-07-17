source("funciones.R")

# unimos ambos dataframes ----

df <- df_data_venta_publicidad_tiendas %>% 
  left_join(df_calendario_festivos, by = 'FECHA_SEMANA_LUNES')

# Comprobamos en que variable hay Na y lo eliminamos ----
fun_NA_df(df)

df <- df %>% 
  filter(!is.na(UNIDADES))


