
# 准备 ----------------------------------------------------------------------

# installation - skip it if done before
install.packages("ggplot2")
install.packages("dplyr")
install.packages("readxl")
install.packages("forcats") # install forcats


library(ggplot2)
library(dplyr)
library(readxl)
library(forcats)

# 导入数据 -----------------------------------------------------------------

data <- read_excel("bank.xlsx")


# 绘图 ----------------------------------------------------------------------


# 客户画像

# 年龄直方图
ggplot(data, aes(x = age)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "年龄分布直方图", x = "年龄", y = "频率") +
  theme_minimal()

# 职业条形图
ggplot(data, aes(x = fct_infreq(job))) +
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
# Version 1
#ggplot(data, aes(x = marital, fill = housing)) +
#  geom_bar(position = "fill") +  # 使用 "fill" 堆叠
#  labs(title = "婚姻状况与住房贷款的关系",
#       x = "婚姻状况",
#       y = "比例") +
#  scale_fill_manual(values = c("blue", "orange"), 
#                    labels = c("无住房贷款", "有住房贷款")) +
#  theme_minimal()

# Version 2
df_prop <- data %>%
  count(marital, housing) %>%
  group_by(marital) %>%
  mutate(prop = n / sum(n),
         label = paste0(round(prop * 100, 1), "%"))

ggplot(df_prop, aes(x = marital, y = prop, fill = housing)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = label), 
            position = position_stack(vjust = 0.5), 
            color = "white", size = 3.5) +
  scale_fill_manual(values = c("skyblue", "tomato")) +
  labs(title = "婚姻状况与住房贷款的关系（含百分比）",
       x = "婚姻状况", y = "比例") +
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

# 促销活动情况

# 联系时长与是否订阅的箱线图
ggplot(data, aes(x = y, y = duration)) +
  geom_boxplot(fill = c("lightblue", "lightpink")) +
  labs(title = "联系时长 vs 是否订阅", x = "是否订阅", y = "联系时长（秒）") +
  ylim(0,2100) +
  theme_minimal()

# 每月联系次数的柱状图
data %>%
  count(month) %>%
  ggplot(aes(x = reorder(month, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "每月联系客户次数", x = "月份", y = "次数") +
  theme_minimal()


# 联系次数与订阅情况的堆栈分组条形图
filtered_data <- data %>% filter(campaign <= 10)

ggplot(filtered_data, aes(x = as.factor(campaign), fill = y)) +
  geom_bar(position = "fill") +
  labs(title = "不同联系次数下的订阅比例（前10次）",
       x = "联系次数（campaign）",
       y = "比例",
       fill = "是否订阅") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = c("lightblue", "tomato")) +
  theme_minimal()

# 之前营销结果与是否订阅的堆栈分组条形图
data %>%
  count(poutcome, y) %>%
  group_by(poutcome) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(aes(x = poutcome, y = prop, fill = y)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "之前营销结果 vs 当前订阅比例", 
       x = "之前营销结果", 
       y = "占比", 
       fill = "是否订阅") +
  scale_fill_manual(values = c("lightgray", "tomato")) +
  theme_minimal()

# 联系日期与时长散点图
#ggplot(data, aes(x = day, y = duration, color = y)) +
  #geom_jitter(alpha = 0.4) +
  #labs(title = "联系日期 vs 时长", x = "日期", y = "联系时长（秒）") +
  #scale_color_manual(values = c("gray", "red")) +
  #theme_minimal()
# 这个地方要去掉一个极端值


# 计算描述性统计量 ----------------------------------------------------------------

vars <- data[, c("age", "duration", "campaign", "pdays", "previous", "balance")]
summary(vars)
sapply(vars, mean, na.rm = TRUE)
sapply(vars, sd, na.rm = TRUE)
