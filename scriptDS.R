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
hist(Airq$rain)


hist(Airq$dens)
hist(Airq$vala)
plot(Airq$coas) # Para dados categóricos, é recomendado utilizar o plot, e não o hist

# Gráficos Exploratórios

# plot(y~x) # y corresponde à variável resposta, enquanto  x é a variável explicativa
   # Sendo assim, y será airq, a qualidade do ar

plot(Airq$airq ~ Airq$rain)
# ou 
plot(airq~rain, data = Airq)

# Construindo retas
abline(lm(Airq$airq ~ Airq$rain))

plot(airq ~ dens, data = Airq)
abline(lm(airq ~ dens, data = Airq))

plot(airq ~ vala, data = Airq)
abline(lm(Airq$airq ~ Airq$vala))

# Personalizando os gráficos
plot(airq ~ vala, data = Airq, xlab = "Valor das empresas", 
     ylab = "Qualidade do ar", main = "Valor das empresas", 
     sub = "Dados de 2017/2018", ylim = c(50, 200), xlim = c(500, 20000),
     cex.lab = 1.3, cex = 1.3, pch = 16, col = "darkblue",
     bty = "n")

abline(lm(Airq$airq ~ Airq$vala), col = "darkred", lwd = 1.5)


#Gráficos de correlação
library(corrgram) # Esse pacote mostra as relações de causa e efeito entre as variáveis
corrgram(Airq, upper.panel = panel.cor)

library(PerformanceAnalytics) # Esse pacote mostra o histograma de cada uma dessas variáveis, além das correlações existentes

# Esse pacote considera apenas valores contínuos, e não categóricos
Airq2 <- Airq[,-5] # Para resolver isso, cria-se um banco de dados temporário com as variáveis que se busca um valor
chart.Correlation(Airq2)


