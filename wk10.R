
# 1 总体均值的区间估计 ---------------------------------------------------------------
# 估计客户总体的平均年龄

t.test(data$age, conf.level = 0.95)

#95 percent confidence interval: 40.85153 41.62954


# 2 单个总体均值的假设检验 -------------------------------------------------------------
# 研究本次营销活动是否针对近期的活跃客户（即过去 15 天内是否联系过）

t.test(data$pdays, mu = 15, alternative = "less")

# alternative hypothesis: true mean is less than 15


# 3 两个总体均值的假设检验 -------------------------------------------------------------
# 研究有无房贷和订阅定期存款意愿的关系

data$y_numeric <- ifelse(data$y == "yes", 1, 0) # 起到一个分类的作用
t.test(y_numeric ~ housing, data = data) #将y_numeric(平均订阅率)转换为y=1, n=0)

# 没有房贷的客户显著更可能订阅定期存款

