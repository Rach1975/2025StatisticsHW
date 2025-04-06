
# 准备 ----------------------------------------------------------------------

# installation - skip it if done before
install.packages("ggplot2")
install.packages("dplyr")
install.packages("readxl")

library(ggplot2)
library(dplyr)
library(readxl)


# 导入数据并分析数据 -----------------------------------------------------------------

data <- read_excel("bank.xlsx")

# 年龄直方图
ggplot(data, aes(x = age)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "年龄分布直方图", x = "年龄", y = "频率") +
  theme_minimal()

# 职业条形图
ggplot(data, aes(x = job)) +
  geom_bar(fill = "steelblue", color = "white", alpha = 0.7) +
  labs(title = "客户职业分布条形图",
       x = "职业",
       y = "数量") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 教育水平饼图
education_counts <- data %>%
  count(education)

ggplot(education_counts, aes(x = "", y = n, fill = education)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  labs(title = "客户教育水平饼图") +
  theme_void()

# 婚姻状况与住房贷款的堆栈分组条形图
ggplot(data, aes(x = marital, fill = housing)) +
  geom_bar(position = "fill") +  # 使用 "fill" 堆叠
  labs(title = "婚姻状况与住房贷款的关系",
       x = "婚姻状况",
       y = "比例") +
  scale_fill_manual(values = c("blue", "orange"), 
                    labels = c("无住房贷款", "有住房贷款")) +
  theme_minimal()

# 信用违约与个人贷款的堆栈分组条形图
ggplot(data, aes(x = default, fill = loan)) +
geom_bar(position = "fill") +  # 使用 "fill" 堆叠
  labs(title = "信用违约与个人贷款的关系",
       x = "信用违约状态",
       y = "比例") +
  scale_fill_manual(values = c("blue", "orange"), 
                    labels = c("无个人贷款", "有个人贷款")) +
  theme_minimal()

# 