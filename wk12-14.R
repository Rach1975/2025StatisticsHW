install.packages("vcd")
install.packages("grid")
install.packages("RcmdrMisc")

# 加载必要的库
library(readxl)  # 用于读取Excel文件
library(vcd)
library(grid)
library(RcmdrMisc)

# 1. 读取数据
data <- read_excel("独立性.xlsx")  # 替换为你的文件路径

# 2. 检查数据结构install.packages("vcd")
install.packages("grid")
install.packages("RcmdrMisc")
# 加载必要的库
library(readxl)  # 用于读取Excel文件
library(vcd)
library(grid)
library(RcmdrMisc)

# 1. 读取数据
data <- read_excel("独立性.xlsx")  # 替换为你的文件路径

# 2. 检查数据结构
str(data)

# 3. 构建列联表
contingency_table <- table(data$housing, data$loan)
print(contingency_table)

# 4. 进行卡方检验
chi_test <- chisq.test(contingency_table)
print(chi_test)

# 5. 可视化列联表
barplot(contingency_table, 
        main = "housing与loan的列联表",
        xlab = "loan",
        ylab = "频数",
        legend = TRUE,
        beside = TRUE)
str(data)

# 3. 构建列联表
contingency_table <- table(data$housing, data$loan)
print(contingency_table)

# 4. 进行卡方检验
chi_test <- chisq.test(contingency_table)
print(chi_test)

# 5. 可视化列联表
barplot(contingency_table, 
        main = "housing与loan的列联表",
        xlab = "loan",
        ylab = "频数",
        legend = TRUE,
        beside = TRUE)