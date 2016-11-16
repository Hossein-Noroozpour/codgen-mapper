v2x = dict()


def bool_filler(s):
    st = str(s)
    if st == "True" or st == "1" or st == "true" or st == "y" or st == "Y" or st == "yes" or st == "Yes" or st == "t":
        return "Y"
    return "N"


def j_date_filler(s):
    if s is None:
        return ""
    d = int(s % 100)
    ss = int(s / 100)
    m = int(ss % 100)
    y = int(ss / 100)

    g_days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    j_days_in_month = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29]
    gy = y - 1600
    gd = d - 1
    g_day_no = 365 * gy + int((gy + 3) / 4) - int((gy + 99) / 100) + int((gy + 399) / 400)
    for i in range(0, m):
        g_day_no += g_days_in_month[i]
    if m > 1 and ((gy % 4 == 0 and gy % 100 != 0) or (gy % 400 == 0)):
        g_day_no += 1
    g_day_no += gd
    j_day_no = g_day_no - 79
    j_np = int(j_day_no / 12053)
    j_day_no %= 12053
    jy = 979 + (33 * j_np) + (4 * int(j_day_no / 1461))
    j_day_no %= 1461
    if j_day_no >= 366:
        jy += int((j_day_no - 1) / 365)
        j_day_no = (j_day_no - 1) % 365
    j = 0
    while True:
        if not (j < 12 and j_day_no >= j_days_in_month[j]):
            break
        j_day_no -= j_days_in_month[j]
        j += 1

    m = j + 1
    d = j_day_no + 1
    y = jy

    return '%04d' % y + "-" + '%02d' % m + "-" + '%02d' % d


def a_date_filler(s):
    if s is None or len(str(s)) < 8:
        return ""
    jd = int(s % 100)
    ss = int(s / 100)
    jm = int(ss % 100)
    jy = int(ss / 100)

    if jy <= 979:
        gy = 621
    else:
        gy = 1600
    if jy > 979:
        jy -= 979

    days = 365 * jy + int(jy / 33) * 8 + int(((jy % 33) + 3) / 4) + 78 + jd
    if jm < 7:
        days += (jm - 1) * 31
    else:
        days += (jm - 7) * 30 + 186
    gy += 400 * int(days / 146097)
    days %= 146097
    if days > 36524:
        days -= 1
        gy += 100 * int(days / 36524)
        days %= 36524
        if days >= 365:
            days += 1
    gy += 4 * int(days / 1461)
    days %= 1461
    gy += int((days - 1) / 365)
    if days > 365:
        days = (days - 1) % 365
    gd = days + 1
    array = [31]
    if ((gy % 4) == 0 and (gy % 100) != 0) or (gy % 400 == 0):
        array.append(29)
    else:
        array.append(28)
    array += [31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    gm = 1
    for v in array:
        if gd <= v:
            break
        gd -= v
        gm += 1
    return '%04d' % gy + "-" + '%02d' % gm + "-" + '%02d' % gd + "T00:00:00"


def return_month_filler(s):
    if s is None:
        return ""
    return str(s).zfill(2)


def identification_info_changed_filler(s):
    return "Y"


def nationality_filler(s):
    if s is None:
        return ""
    n = int(s)
    if n == 1 or n == 10244:
        return "01"
    if n == 9057:
        return "02"


def unicode_filler(s):
    # ss = s.decode("utf-8")
    return s


def country_filler(s):
    from countries import countries
    return countries[s]


def employee_degree_filler(s):
    if s is None:
        return ""
    if s == 8355 or s == 10176 or s == 1:
        return "01"
    if 9034 == s or s == 6:
        return "06"
    if 9372 == s or s == 4:
        return "04"
    if 9397 == s or s == 7:
        return "07"
    if 9636 == s or s == 5:
        return "05"
    if 9838 == s or s == 2:
        return "02"
    if 10175 == s or s == 3:
        return "03"


def employee_insurance_type_filler(s):
    if s is None:
        return ""
    if s == 9120 or s == 2:
        return "02"
    if s == 9223 or s == 1:
        return "01"
    if s == 9253 or s == 4:
        return "04"
    if s == 10095 or s == 5:
        return "05"
    if s == 10738 or s == 3:
        return "03"


def employment_type_filler(s):
    if s is None:
        return ""
    if s == 7849:
        return "06"
    if s == 8251:
        return "01"
    if s == 8524:
        return "06"
    if s == 9228:
        return "04"
    if s == 9248:
        return "05"
    if s == 9387:
        return "06"
    if s == 9398:
        return "06"
    if s == 9783:
        return "03"
    if s == 9821:
        return "06"
    if s == 9968:
        return "06"
    if s == 10199:
        return "06"
    return "06"


def allocated_area_status_filler(s):
    if s is None or len(str(s).strip()) == 0:
        return ""
    if s == 10388 or s == 1:
        return "01"   # عادي
    if s == 10389 or s == 2:
        return "02"   # مناطق کمتر توسعه يافته
    if s == 10391 or s == 3:
        return "03"   # مناطق آزاد تجاري
    return ""


def employee_status_filler(s):
    if s is None or len(str(s).strip()) == 0:
        return ""
    if s == 8225 or s == 2:
        return "02"  # جانبازان انقلاب اسلامي و جنگ تحميلي
    if s == 8410 or s == 3:
        return "03"  # فرزندان شاهد در طول برنامه پنجم توسعه (90 تا 94)
    if s == 8578 or s == 5:
        return "05"  # مشمولان قانون استخدامي وزارت اطلاعات
    if s == 8794:
        return "05"  # شاغلين در مناطق کمتر توسعه يافته(50% معافيت م 92)
    if s == 8856 or s == 1:
        return "01"  # عدم معافيت
    if s == 9531:
        return "01"  # شاغلين در مناطق آزاد تجاري - صنعتي
    if s == 9882:
        return "05"  # پرسنل نيروهاي مسلح جمهوري اسلامي ايران اعم از نظام
    if s == 9932 or s == 4:
        return "04"  # آزادگان
    if s == 10739 or s == 7:
        return "07"  # اجتناب از اخذ ماليات مضاعف
    if s == 10740 or s == 6:
        return "06"  # ساير مشمولين بند 14 ماده 91
    return ""


def paid_type_filler(s):
    if s is None or len(str(s).strip()) == 0:
        return ""
    return str(s).zfill(2)


def currency_type_filler(s):
    if s is None or len(str(s).strip()) == 0:
        return ""
    if s == 10504:
        return "XOF"
    if s == 10506:
        return "XAF"
    if s == 10507:
        return "GBP"
    if s == 10518:
        return "MOP"
    if s == 10522:
        return "CLP"
    if s == 10542:
        return "AUD"
    if s == 10543:
        return "USD"
    if s == 10576:
        return "ZAR"
    if s == 10586:
        return "MVR"
    if s == 10587:
        return "IRR"
    if s == 10588:
        return "SAR"
    if s == 10589:
        return "OMR"
    if s == 10591:
        return "YER"
    if s == 10596:
        return "TJS"
    if s == 10661:
        return "EUR"
    print("Unknown currency, code is:", s)
    return ""
    # if s == :
    #     return ""


def housing_flag_filler(s):
    if s is None or len(str(s).strip()) == 0:
        return ""
    if s == 8379:
        return "03"  # 113	استفاده از مسکن بدون اثاثيه
    if s == 8781:
        return "01"  # 113	عدم استفاده از مسکن
    if s == 9799:
        return "02"  # 113	استفاده از مسکن با اثاثيه


def vehicle_flag_filler(s):
    if s is None or len(str(s).strip()) == 0:
        return ""
    if s == 8478:
        return "01"  # 114	عدم استفاده از اتومبيل
    if s == 8913:
        return "03"  # 114	استفاده از اتومبيل بدون راننده
    if s == 9188:
        return "02"  # 114	استفاده از اتومبيل با راننده


def payment_type_filler(s):
    if s is None or len(str(s).strip()) == 0:
        return ""
    if s == 8384:
        return "06"  # 104	واريز نقدي
    if s == 9385:
        return ""  	# 104	ارائه ليست بدون پرداخت ماليات
    if s == 10387:
        return "07"	  # 104	پرداخت خزانه
    if s == 10708:
        return "01"	   #	104	چک شخصي
    if s == 10709:
        return "02"	   #	104	پرداخت با کارت اعتباري
    if s == 10710:
        return "03"  	#	104	انتقال بانکي
    if s == 10711:
        return "04"	#	104	سفته
    if s == 10712:
        return "05"	#	104	چک تضمين شده
    return ""


def bank_filler(s):
    if s is None or len(str(s).strip()) == 0:
        return ""
    if s == 7904:
        return "BEDIRA"
    if s == 7931:
        return "BREFAH"
    if s == 8139:
        return "BEGHTE"
    if s == 8182:
        return "BINDMI"
    if s == 8256:
        return 'BMASKA'
    if s == 8276:
        return 'BKSINA'
    if s == 8366:
        return 'BSADER'
    if s == 8506:
        return 'BMELLI'
    if s == 8604:
        return 'BKESHA'
    if s == 8715:
        return 'BSEPAH'
    if s == 8761:
        return 'BPASAR'
    if s == 8815:
        return 'BMELLA'
    if s == 8835:
        return 'BCDEVE'
    if s == 8892:
        return 'BNKTAT'
    if s == 9074:
        return 'BKARAF'
    if s == 9226:
        return 'BNKDAY'
    if s == 9463:
        return 'BKPOST'
    if s == 9477:
        return ''
    if s == 9572:
        return 'BSARMA'
    if s == 9579:
        return ''
    if s == 9840:
        return 'BKCITY'
    if s == 10071:
        return 'BTEJAR'
    if s == 10112:
        return 'BSAMAN'
    if s == 10127:
        return 'BPARSI'
    if s == 10190:
        return 'BANSAR'
    if s == 10733:
        return 'BCENTR'
    if s == 10734:
        return 'BGHARZ'
    if s == 10735:
        return 'BHEKMA'
    if s == 10736:
        return 'BTOURI'
    if s == 10737:
        return ''
    return ''


v2x["salary_payment_art_86"] = bool_filler
v2x["allocation_Payment_jornal"] = a_date_filler
v2x["salary_payment_note_86"] = bool_filler
v2x["return_month"] = return_month_filler
v2x["identification_info_changed"] = identification_info_changed_filler
v2x["nationality"] = nationality_filler
v2x["employee_name"] = unicode_filler
v2x["employee_surname"] = unicode_filler
v2x["country"] = country_filler
v2x["employee_degree"] = employee_degree_filler
v2x["employee_inssurance_type"] = employee_insurance_type_filler
v2x["employee_position_fixed_rate"] = bool_filler
v2x["employment_date"] = a_date_filler
v2x["employment_type"] = employment_type_filler
v2x["allocated_area_status"] = allocated_area_status_filler
v2x["last_month_salary"] = bool_filler
v2x["work_end_date"] = a_date_filler
v2x["employee_status"] = employee_status_filler
v2x["payment_done_by_original_provision_wagepayer"] = bool_filler
v2x["paid_type"] = paid_type_filler
v2x["currency_type"] = currency_type_filler
v2x["housing_flag"] = housing_flag_filler
v2x["vehicle_flag"] = vehicle_flag_filler
v2x["end_month_salary"] = bool_filler
v2x["identification_info_changed_t4"] = bool_filler
v2x["payment_type"] = payment_type_filler
v2x["bank"] = bank_filler
v2x["slip_date"] = a_date_filler
