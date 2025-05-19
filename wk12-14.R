

# 2 独立性检验 -----------------------------------------------------------------

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


# 3 方差分析 --------------------------------------------------------------------

# 加载必要的库
library(readxl)  # 用于读取Excel文件
library(ggplot2) # 用于绘图

# 1. 读取数据
data <- read_excel("方差分析.xlsx") 

# 2. 数据预处理：去掉contact为unknown的数据
data <- data[data$contact != "unknown", ]

# 3. 进行方差分析
# 检查数据结构
str(data)

# 确保duration是数值类型
data$duration <- as.numeric(data$duration)

# 进行单因素方差分析
aov_result <- aov(duration ~ contact, data = data)
summary(aov_result)  # 查看方差分析结果

# 4. 结果可视化：绘制箱线图
ggplot(data, aes(x = contact, y = duration)) +
  geom_boxplot() +
  labs(title = "不同联系方式下的通话时间分布",
       x = "联系方式",
       y = "通话时间 (秒)") +
  theme_minimal()

# 5. 多重比较：如果ANOVA结果显著，进行Tukey HSD检验
if(summary(aov_result)[[1]]$`Pr(>F)`[1] < 0.05) {
  tukey_result <- TukeyHSD(aov_result)
  print(tukey_result)  # 查看多重比较结果
} else {
  cat("ANOVA结果不显著，无需进行多重比较。\n")
}



# 4 相关分析 --------------------------------------------------------------------

install.packages("readxl")
library(readxl)

# 读取Excel数据
data <- read_excel("相关分析.xlsx", sheet = "Sheet1")

# 数据预处理：过滤pdays为-1的观测（从未联系过的客户）
filtered_data <- subset(data, pdays != -1)

# 检查数据摘要
cat("数据摘要：\n")
summary(filtered_data)

# 绘制散点图观察关系
plot(filtered_data$campaign, filtered_data$pdays,
     main = "联系次数与距离上次联系天数的关系",
     xlab = "本次活动联系次数 (campaign)",
     ylab = "距离上次联系天数 (pdays)",
     pch = 19, col = "steelblue")

# 计算皮尔逊相关系数及检验
pearson_test <- cor.test(filtered_data$campaign, filtered_data$pdays, method = "pearson")

# 计算斯皮尔曼相关系数及检验（非参数方法）
spearman_test <- cor.test(filtered_data$campaign, filtered_data$pdays, method = "spearman")

# 输出结果
cat("\n皮尔逊相关系数分析结果：\n")
print(pearson_test)

cat("\n斯皮尔曼相关系数分析结果：\n")
print(spearman_test)


