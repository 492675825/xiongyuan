from django.db import models

# Create your models here.

class tbl_d_hr(models.Model):
    satisfaction_level = models.CharField(max_length=5,verbose_name='满意度')
    last_evaluation = models.CharField(max_length=5,verbose_name='最后评分')
    number_project = models.CharField(max_length=5,verbose_name='项目数量')
    average_monthly_hours = models.CharField(max_length=5,verbose_name='平均月工作时长')
    time_spend_company = models.CharField(max_length=5,verbose_name='工作时间')
    Work_accident = models.CharField(max_length=5,verbose_name='工作事故')
    left = models.CharField(max_length=2,verbose_name='是否离职')
    promotion_last_5years = models.CharField(max_length=2,verbose_name='5年晋升')
    department = models.CharField(max_length=20,verbose_name='部门')
    salary = models.CharField(max_length=20,verbose_name='工资水平')

    class Meta:
        verbose_name='员工表'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.left