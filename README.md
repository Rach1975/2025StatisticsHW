# 2025StatisticsHW

统计学作业

## 2025/4/6

- 使用 bank.csv 作为数据集
- 对数据进行清理
- 绘图分析和计算描述性统计量
- 将结果整理到 word 文档

### 关于数据集的说明

#### 原数据集

Input variables:

- 1-8 bank client data 客户数据
- 9-12 related with the last contact of the current campaign 与上次的促销活动相关
- 13-16 other attributes 其他属性
- 17 Output variable (desired target) 结果变量

1. age (numeric)
2. job : type of job (categorical: "admin.","unknown","unemployed","management","housemaid","entrepreneur","student","blue-collar","self-employed","retired","technician","services")
3. marital : marital status (categorical: "married","divorced","single"; note: "divorced" means divorced or widowed)
4. education (categorical: "unknown","secondary","primary","tertiary")
5. default: has credit in default? (binary: "yes","no")
6. balance: average yearly balance, in euros (numeric)
7. housing: has housing loan? (binary: "yes","no")
8. loan: has personal loan? (binary: "yes","no")
9. contact: contact communication type (categorical: "unknown","telephone","cellular")
10. day: last contact day of the month (numeric)
11. month: last contact month of year (categorical: "jan", "feb", "mar", ..., "nov", "dec")
12. duration: last contact duration, in seconds (numeric)
13. campaign: number of contacts performed during this campaign and for this client (numeric, includes last contact)
14. pdays: number of days that passed by after the client was last contacted from a previous campaign (numeric, -1 means client was not previously contacted)
15. previous: number of contacts performed before this campaign and for this client (numeric)
16. poutcome: outcome of the previous marketing campaign (categorical: "unknown","other","failure","success")
17. y - has the client subscribed a term deposit? (binary: "yes","no")

#### 对于数据集的处理

- 删除具有"unknown"（除 poutcome）关键字的行：原样本数 4521，删除后为 3064

#### 变量说明

- 定性变量：job, marital, education, default, housing, loan, contact, month, day, poutcome, y
- 定量变量：age, duration, campaign, pdays, previous, balance

### 绘图思路

**描述客户画像**

- 直方图：age
- 条形图：job
- 饼图：education
- 堆栈分组条形图：按照 marital 分组，画 housing；按照 default 分组，画 loan

**描述上次促销活动情况**

- 联系时长与是否订阅的箱线图
- 每月联系次数的柱状图
- 联系次数与订阅情况的堆栈分组条形图
- 之前营销结果与是否订阅的堆栈分组条形图
- 联系日期与时长散点图

### 疑问

- 这个 average yearly balance 分组分起来还是挺麻烦的
- 直方图：画 balance (500 一组，上溢 2400，下溢-80) 如何 实现？
