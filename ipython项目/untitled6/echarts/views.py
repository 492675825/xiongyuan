from django.shortcuts import render,redirect
from django.http import HttpResponse
from .models import tbl_d_hr
import pandas as pd
import numpy as np

from .forms import DataPredict
from django.template.loader import get_template


# Create your views here.

def Index(request):
    user = tbl_d_hr.objects.all()
    context = {
        'user_tbl': user,
    }
    return render(request, '../templates/index.html', context)


def Data(request):
    user = tbl_d_hr.objects.all()
    context = {
        'user_tbl': user,
    }
    return render(request, '../templates/data.html', context)


def Base(request):
    user = tbl_d_hr.objects.all()
    context = {
        'user_tbl': user,
    }
    return render(request, '../templates/base.html', context)


# def Predict(request):
#     # 将数据库的内容显示到前端
#     user = tbl_d_hr.objects.all()
#     context = {
#         'user_tbl': user,
#     }
#
#     return render(request, '../templates/predict.html', context)

def data_predict(request):
    if request.method=='POST':
        sa_le = request.POST.get('sl','')
        ls_ev = request.POST.get('le','')
        nu_pr = request.POST.get('np','')
        av_mh = request.POST.get('avg','')
        ts_com = request.POST.get('ts','')
        wo_ac = request.POST.get('wa','')
        lf = request.POST.get('lf','')
        pro_lst = request.POST.get('pl','')
        dp = request.POST.get('dp','')
        sl = request.POST.get('sal','')
        if sa_le and ls_ev and nu_pr and av_mh and ts_com\
            and wo_ac and lf and pro_lst and dp and sl:
            tbl_d_hr.objects.create(satisfaction_level=sa_le, last_evaluation=ls_ev, \
                                    number_project=nu_pr, average_monthly_hours=av_mh, \
                                    time_spend_company=ts_com, Work_accident=wo_ac, \
                                    left=lf, promotion_last_5years=pro_lst, \
                                    department=dp, salary=sl)
            return redirect('/')
        else:
            return HttpResponse('请输入完成全部内容的填写')
    return render(request,'../templates/predict.html')
