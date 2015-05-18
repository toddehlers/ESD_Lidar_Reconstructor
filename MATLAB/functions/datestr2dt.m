function dt = datestr2dt(date1,date2)

DD = str2double(datestr(date2,'dd')) - str2double(datestr(date1,'dd'));
HH = str2double(datestr(date2,'HH')) - str2double(datestr(date1,'HH'));
MM = str2double(datestr(date2,'MM')) - str2double(datestr(date1,'MM'));

dt = DD*24 + HH + MM/60;

end