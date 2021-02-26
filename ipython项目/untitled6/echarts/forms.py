from django import forms

class DataPredict(forms.Form):
    sat_le = forms.CharField()
    lst_eval = forms.CharField()
    num_pro = forms.CharField()
    avg_m_hours = forms.CharField()
    time_sd_com = forms.CharField()
    work_acc = forms.CharField()
    le = forms.CharField()
    pro_lst_5 = forms.CharField()
    dep = forms.CharField()
    sal = forms.CharField()