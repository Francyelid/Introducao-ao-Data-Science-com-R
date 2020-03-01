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

# Modelo estatístico
modelo <- glm(airq ~ vala + rain + coas + dens + medi, data = Airq)

# Selecionando variáveis significativas
library(MuMIn)
options(na.action = "na.fail")

dredge(modelo, rank = "AIC") # critério de akalke

# Criando o gráfico final
library(ggplot2)

# Gráfico de regressão
ggplot(data = Airq, aes(x = medi, y = airq)) + geom_point(size = 2) + 
      geom_smooth(method = "glm", se = FALSE) + 
      labs(x = "Renda média", y = "Qualidade do ar")

# BoxPlot
ggplot(data = Airq, aes(x = coas, y = airq)) + geom_boxplot(aes(color = coas)) + 
       labs(x = "Posição costeira", y = "Qualidade do ar", color = "")

# ANCOVA (y contínuo - x contínuo +  categórico)
ggplot(data = Airq, aes(x = medi, y = airq, group = coas)) + geom_point(size = 2) + 
      geom_smooth(method = "glm", aes(color = coas),se = FALSE) + 
      labs(x = "Renda média", y = "Qualidade do ar", color = "Posição costeira")

#################################################################################
# CONCLUSÃO
   # A qualidade do ar diminui confome a renda média aumenta. Além disso, cidades
   # não costeira apresentam qualidade do ar pior quando comparado com cidades não costeiras.
