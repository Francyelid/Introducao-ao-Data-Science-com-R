# Carregando os dados de um arquivo .csv
Airq <- read.csv("~/Cursos/R/R - Introducao ao Data Science/Datas/Airq.csv")
View(Airq)

# Panorama geral dos dados
summary(Airq)

# Os dados mostram o quê interfere na qualidade do ar nas cidades

      # AIRQ: Índice para medir a qualidade do ar (quanto menor, melhor)
      # VALA: Valor das empresas nas cidades (milhares de doláres) 
      # RAIN: Quantidade de chuva (polegadas)
      # COAS: Se a cidade é costeira (Variável categorica)
      # DENS: Densidade da população (milha quadrado)
      # MEDI: Renda média per capita (dólares)

# Plotando gráficos das variáveis
plot(Airq$coas)
plot(Airq$rain)

# OBS: Quando há a presença de uma variável categórica (semelhante a um Enum)
######################################################
x <- c(0, 1, 2, 3, 4)

x1 <- as.factor(x)
######################################################

# Fazendo um histograma dos dados
hist(Airq$airq)
