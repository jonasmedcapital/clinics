class DateDecorator < SimpleDelegator  

  def self.abbr_month_date(date)
    return "#{I18n.t("date.abbr_day_numbers")[date.day]}/#{I18n.t("date.abbr_month_names")[date.month]}/#{date.year}"
  end

  def self.pick_date(date)
    return "#{I18n.t("date.abbr_day_numbers")[date.day]}/#{I18n.t("date.abbr_month_numbers")[date.month]}/#{date.year}"
  end

  def self.abbr_year(date)
    return "#{I18n.t("date.abbr_day_numbers")[date.day]}/#{I18n.t("date.abbr_month_names")[date.month]}/#{date.strftime('%y')}"
  end

  def self.abbr_with_day_month(date)
    return "#{I18n.t("date.abbr_day_numbers")[date.day]}/#{I18n.t("date.abbr_month_names")[date.month]}"
  end

  def self.pretty_with_month_year(date)
    return "#{I18n.t("date.abbr_month_names")[date.month]}/#{date.year}"
  end

  def self.abbr_with_month_year(month, year)
    if month > 0
      return "#{I18n.t("date.abbr_month_names")[month]}-#{year}"
    else
      return "#{year}"
    end
  end

  def self.date_parse_translate_pt(date)
    return Date.parse(date.gsub(date.split("/")[1],DateDecorator::TRANSLATE[date.split("/")[1]]))
  end

  def self.full_extension(date)
    return "#{I18n.t("date.abbr_day_numbers")[date.day]} de #{I18n.t("date.month_names")[date.month]} de #{date.year}"
  end
  

  def self.find_month(month)
    return 
  end

  WEEK_DAY = {
                0 => "Domingo",
                1 => "Segunda",
                2 => "Terça",
                3 => "Quarta",
                4 => "Quinta",
                5 => "Sexta",
                6 => "Sábado",
              }
  

  TRANSLATE = {
                "Jan" => "Jan",
                "Fev" => "Feb",
                "Mar" => "Mar",
                "Abr" => "Apr",
                "Mai" => "May",
                "Jun" => "Jun",
                "Jul" => "Jul",
                "Ago" => "Aug",
                "Set" => "Sep",
                "Out" => "Oct",
                "Nov" => "Nov",
                "Dez" => "Dec",
              }

  MONTH_PRETTY = {
                    "1" => "Janeiro",
                    "2" => "Fevereiro",
                    "3" => "Março",
                    "4" => "Abril",
                    "5" => "Maio",
                    "6" => "Junho",
                    "7" => "Julho",
                    "8" => "Agosto",
                    "9" => "Setembro",
                    "10" => "Outubro",
                    "11" => "Novembro",
                    "12" => "Dezembro",
                  }

  MONTH_PRETTY_SHORT = {
                          "1" => "Jan",
                          "2" => "Fev",
                          "3" => "Mar",
                          "4" => "Abr",
                          "5" => "Mai",
                          "6" => "Jun",
                          "7" => "Jul",
                          "8" => "Ago",
                          "9" => "Set",
                          "10" => "Out",
                          "11" => "Nov",
                          "12" => "Dez",
                        }

end