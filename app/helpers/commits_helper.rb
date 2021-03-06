module CommitsHelper
  def old_line_number(line, i)

  end

  def new_line_number(line, i)

  end

  def diff_line_class(line)
    if line[0] == "+"
      "new"
    elsif line[0] == "-"
      "old"
    else
      nil
    end
  end

  def more_commits_link
    offset = params[:offset] || 0
    limit = params[:limit] || 100
    link_to "More", project_commits_path(@project, :offset =>  offset.to_i + limit.to_i, :limit => limit),
      :remote => true, :class => "lite_button vm", :style => "text-align:center; width:930px; ", :id => "more-commits-link"
  end

  def commit_msg_with_link_to_issues(project, message)
    return '' unless message
    out = ''
    message.split(/(#[0-9]+)/m).each do |m|
      if m =~ /(#([0-9]+))/m
        begin
          issue = project.issues.find($2)
          out += link_to($1, project_issue_path(project, $2))
        rescue
          out += $1
        end
      else
        out += m
      end
    end
    preserve out
  end

  def build_line_code(line, index, line_new, line_old)
    if diff_line_class(line) == "new"
      "NEW_#{index}_#{line_new}"
    else
      "OLD_#{index}_#{line_old}"
    end
  end
end
