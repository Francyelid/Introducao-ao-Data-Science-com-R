# Carregando os dados de um arquivo .csv
Airq <- read.csv("~/Cursos/R/R - Introducao ao Data Science/Datas/Airq.csv")
View(Airq)

# Panorama geral dos dados
summary(Airq)

# Os dados mostram o qu� interfere na qualidade do ar nas cidades

      # AIRQ: �ndice para medir a qualidade do ar (quanto menor, melhor)
      # VALA: Valor das empresas nas cidades (milhares de dol�res) 
      # RAIN: Quantidade de chuva (polegadas)
      # COAS: Se a cidade � costeira (Vari�vel categorica)
      # DENS: Densidade da popula��o (milha quadrado)
      # MEDI: Renda m�dia per capita (d�lares)

# Plotando gr�ficos das vari�veis
plot(Airq$coas)
plot(Airq$rain)

# OBS: Quando h� a presen�a de uma vari�vel categ�rica (semelhante a um Enum)
######################################################
x <- c(0, 1, 2, 3, 4)

x1 <- as.factor(x)
######################################################

# Fazendo um histograma dos dados
hist(Airq$airq)
hist(Airq$rain)


hist(Airq$dens)
hist(Airq$vala)
plot(Airq$coas) # Para dados categ�ricos, � recomendado utilizar o plot, e n�o o hist

# Gr�ficos Explorat�rios

# plot(y~x) # y corresponde � vari�vel resposta, enquanto  x � a vari�vel explicativa
   # Sendo assim, y ser� airq, a qualidade do ar

plot(Airq$airq ~ Airq$rain)
# ou 
plot(airq~rain, data = Airq)

# Construindo retas
abline(lm(Airq$airq ~ Airq$rain))

plot(airq ~ dens, data = Airq)
abline(lm(airq ~ dens, data = Airq))

plot(airq ~ vala, data = Airq)
abline(lm(Airq$airq ~ Airq$vala))

# Personalizando os gr�ficos
plot(airq ~ vala, data = Airq, xlab = "Valor das empresas", 
     ylab = "Qualidade do ar", main = "Valor das empresas", 
     sub = "Dados de 2017/2018", ylim = c(50, 200), xlim = c(500, 20000),
     cex.lab = 1.3, cex = 1.3, pch = 16, col = "darkblue",
     bty = "n")

abline(lm(Airq$airq ~ Airq$vala), col = "darkred", lwd = 1.5)


#Gr�ficos de correla��o
library(corrgram) # Esse pacote mostra as rela��es de causa e efeito entre as vari�veis
corrgram(Airq, upper.panel = panel.cor)

library(PerformanceAnalytics) # Esse pacote mostra o histograma de cada uma dessas vari�veis, al�m das correla��es existentes

# Esse pacote considera apenas valores cont�nuos, e n�o categ�ricos
Airq2 <- Airq[,-5] # Para resolver isso, cria-se um banco de dados tempor�rio com as vari�veis que se busca um valor
chart.Correlation(Airq2)

# Modelo estat�stico
modelo <- glm(airq ~ vala + rain + coas + dens + medi, data = Airq)

# Selecionando vari�veis significativas
library(MuMIn)
options(na.action = "na.fail")

dredge(modelo, rank = "AIC") # crit�rio de akalke

# Criando o gr�fico final
library(ggplot2)

# Gr�fico de regress�o
ggplot(data = Airq, aes(x = medi, y = airq)) + geom_point(size = 2) + 
      geom_smooth(method = "glm", se = FALSE) + 
      labs(x = "Renda m�dia", y = "Qualidade do ar")

# BoxPlot
ggplot(data = Airq, aes(x = coas, y = airq)) + geom_boxplot(aes(color = coas)) + 
       labs(x = "Posi��o costeira", y = "Qualidade do ar", color = "")

# ANCOVA (y cont�nuo - x cont�nuo +  categ�rico)
ggplot(data = Airq, aes(x = medi, y = airq, group = coas)) + geom_point(size = 2) + 
      geom_smooth(method = "glm", aes(color = coas),se = FALSE) + 
      labs(x = "Renda m�dia", y = "Qualidade do ar", color = "Posi��o costeira")

#################################################################################
# CONCLUS�O
   # A qualidade do ar diminui confome a renda m�dia aumenta. Al�m disso, cidades
   # n�o costeira apresentam qualidade do ar pior quando comparado com cidades n�o costeiras.
