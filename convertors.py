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
    if s is None:
        return ""
    d = int(s % 100)
    ss = int(s / 100)
    m = int(ss % 100)
    y = int(ss / 100)

    if y <= 979:
        gy = 621
    else:
        gy = 1600
    if y > 979:
        y -= 979

    gd = 365 * y + int(y / 33) * 8 + int(((y % 33) + 3) / 4) + 78 + d
    if m < 7:
        gd += (m - 1) * 31
    else:
        gd += (m - 7) * 30 + 186
    gy += 400 * int(gd / 146097)
    gd %= 146097
    if gd > 36524:
        gd -= 1
        gy += 100 * int(gd / 36524)
        gd %= 36524
        if gd >= 365:
            gd += 1
    gy += 4 * int(gd / 1461)
    gd %= 1461
    gy += int((gd - 1) / 365)
    if gd > 365:
        gd = (gd - 1) % 365
    gd += 1
    array = [31]
    if ((gy % 4) == 0 and (gy % 100) != 0) or (gy % 400 == 0):
        array.append(29)
    else:
        array.append(28)
    array += [31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    for v in array:
        if gd <= v:
            break
        gd -= v
    return '%04d' % gy + "-" + '%02d' % gm + "-" + '%02d' % gd

v2x["salary_payment_art_86"] = bool_filler
v2x["allocation_payment_jornal"] = date_filler
v2x["salary_payment_note_86"] = bool_filler
v2x["identification_info_changed"] = bool_filler
v2x["employee_position_fixed_rate"] = bool_filler
v2x["last_month_salary"] = bool_filler
v2x["payment_done_by_original_provision_wagepayer"] = bool_filler
v2x["end_month_salary"] = bool_filler
v2x["identification_info_changed_t4"] = bool_filler


def cnv(s):
    pass

v2x["foo"] = cnv

