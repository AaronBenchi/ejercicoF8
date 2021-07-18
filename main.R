source("funciones.R")

# unimos ambos dataframes ----

df <- df_data_venta_publicidad_tiendas %>% 
  left_join(df_calendario_festivos, by = 'FECHA_SEMANA_LUNES')

# Comprobamos en que variable hay Na y lo eliminamos ----
fun_NA_df(df)

df <- df %>% 
  filter(!is.na(UNIDADES))

# Análisis de datos ----

# Añadimos variable año, semana
df <- df %>%
  mutate(FECHA_SEMANA_LUNES =  as.Date(FECHA_SEMANA_LUNES)) %>% 
  mutate(anio = year(FECHA_SEMANA_LUNES))

# Por año
# numero de semanas 
df %>% 
  group_by(anio) %>% 
  count() %>% 
  rename(semanas = n)

# Suma de unidades vendidas
# Media de unidades vendidas
# Suma de GRPs
# Media de GRPs
df %>% 
  group_by(anio) %>% 
  summarise(unidades_vendidas = sum(UNIDADES), 
            media_unidades_vendidas = mean(UNIDADES),
            total_GRPs = sum(GRPs),
            mean_GRPs = mean(GRPs))

# Construimos un agregado por la variable FESTIVOS que calcule:
# Mediana de unidades.

df %>% 
  group_by (FESTIVOS) %>% 
  summarise(media_unidades_vendidas = median(UNIDADES))

# Construimos un agregado mensual que calcule:
# Suma de tiendas abiertas.
# Suma de GRPs.
# Suma de unidades.

names(df)

df %>% 
  mutate(mes = month(FECHA_SEMANA_LUNES, label = TRUE, abbr = FALSE)) %>% 
  group_by (mes) %>% 
  summarise(tiendas_abiertas = sum(TIENDAS_ABIERTAS),
            total_GRPs = sum(GRPs),
            unidades_vendidas = sum(UNIDADES))

# Suma de festivos por meses
df %>% 
  mutate(mes = month(FECHA_SEMANA_LUNES, label = TRUE, abbr = FALSE)) %>% 
  filter(FESTIVOS > 0) %>% 
  group_by (mes) %>% 
  count(FESTIVOS) %>% 
  rename(num_festivos_tipo_1_2 = n)
