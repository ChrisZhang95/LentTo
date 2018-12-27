module ApplicationHelper
    def full_title(page_title)
        base_title = "LendTo"
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end

    def flash_class(level)
        case level
            when :notice then "alert-info"
            when :success then "alert-success"
            when :error then "alert-danger"
            when :alert then "alert-danger"
        end
    end

    def flash_icon(level)
        case level
            when :notice then "&excl;"
            when :success then "&check;"
            when :error then "&cross;"
            when :alert then "&cross;"
        end
    end

    def logged_user(partial = true)
        begin
            if partial
                current_user.profile.first_name
            else
                current_user.profile.first_name + " " + current_user.profile.last_name
            end
        rescue
            "User"
        end
    end

    def settings_menu_active(menu_item, static_menu)
        if menu_item == static_menu
            "active"
        else
            ""
        end
    end

    def is_public_text(bool_yes)
        if bool_yes == "Yes" || bool_yes == true || bool_yes == "true"
            "Publicly Available"
        else
            "Private Item"
        end
    end

    def get_picture(user, _class)
        if user.profile.avatar.attached?
            #byebug
            image_tag(user.profile.avatar, class:_class) rescue nil
        elsif user.profile.picture && !user.profile.picture.blank?
            # byebug
            image_tag(user.profile.picture, class: _class) rescue nil
        else
            #byebug
            image_tag("default_user.png", class: _class) rescue nil
        end
    end

    def job_text(job)
        if job && !job.blank?
            job
        else
            "Unknown"
        end
    end

    def link_help(link)
        if link && !link.blank?
            link
        else
            "javascript:void();"
        end
    end


end
