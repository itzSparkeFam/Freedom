resourcename = window.location.hostname;

$(function () {
    function Toggelitem(id, bool) {
        if (bool) {
            $(id).show();
        } else {
            $(id).hide();
        }
    }

    function GetStringPart(s, start, end){
        part = ""
        for(i = start; i < end; i++)
            part += s[i]
        return part;
    }

    Toggelitem("#citation", false)
    Toggelitem("#mycitationsmenu", false)
    Toggelitem("#controlpanel", false)
    Toggelitem("#scan_btn", false)
    Toggelitem("#print_btn", false)
    Toggelitem("#pay_cash_btn", false)
    Toggelitem("#pay_bank_btn", false)
    Toggelitem("#suggest_scroll", false)
    Toggelitem("#paid_icon", false)

    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type === "citation") {
            Toggelitem("#citation", item.status)
            if(item.status){
                if(item.info.isCopInCar){
                    Toggelitem("#scan_btn", true)
                }
                FillCitationInfo(item.info.citations, false)
            }
        } else if(item.type === "paymenu"){
            Toggelitem("#mycitationsmenu", true)
            Toggelitem("#citation", false)
            FillMyCitationsList(item.info.citations)
            if(item.info.citations.length <= 0){
                Toggelitem("#mycitationsmenu", false)
            }
        } else if(item.type === "controlpanel"){
            Toggelitem("#controlpanel", true)
            Toggelitem("#citation", false)
        } else if(item.type === "exit"){
            Toggelitem("#mycitationsmenu", false)
            Toggelitem("#controlpanel", false)
            Toggelitem("#citation", false)
            Toggelitem("#scan_btn", false)
            Toggelitem("#paid_icon", false)
            Toggelitem("#print_btn", false)
            Toggelitem("#pay_cash_btn", false)
            Toggelitem("#pay_bank_btn", false)
        } else if(item.type === "resourcename"){
            resourcename = item.info
        }
    })

    shiftDown = false

    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            Toggelitem("#mycitationsmenu", false)
            i = GetCitationData()
            $.post('http://'+resourcename+'/exit', JSON.stringify({
                citationid: i.citationid, lastname: i.lastname, firstname: i.firstname, date: i.date, postal: i.postal, street: i.street, plate: i.plate, make: i.make, color: i.color, type: i.type, officerName: i.officerName, badge: i.badge, agency: i.agency,
                code1: i.code1, code2: i.code2, code3: i.code3, officerSign: i.officerSign, susSign: i.susSign, comments: i.comments
            }));
            return;
        } else if(data.which == 16) {
            shiftDown = false
        } else if(data.which == 8){
            el = document.activeElement
            if(GetStringPart(el.id, 0, 6) == "plate_"){
                plateIndex = parseInt(el.id[el.id.length - 1])
                if(plateIndex == 1)
                    plateIndex = 8
                else
                    plateIndex = plateIndex - 1
                document.getElementById("plate_"+plateIndex).focus()
            }
        }
    };

    // if the person uses the escape key, it will exit the resource
    document.onkeydown = function (data) {
        if(data.which == 16) {
            shiftDown = true
        }
    };

    function FillCitationInfo(cinfo, readonly){
        document.getElementById("citation_id").innerHTML = cinfo.citationid
        document.getElementById("sus_lastname").value = cinfo.lastname
        document.getElementById("sus_firstname").value = cinfo.firstname
        document.getElementById("date").value = cinfo.date
        document.getElementById("postal").value = cinfo.postal
        document.getElementById("street").value = cinfo.street
        for(i = 0; i < cinfo.plate.length; i++){
            document.getElementById("plate_"+(i+1)).value = cinfo.plate[i]
        }
        for(i = cinfo.plate.length; i < 8; i++){
            document.getElementById("plate_"+(i+1)).value = ""
        }
        document.getElementById("veh_make").value = cinfo.make
        document.getElementById("veh_color").value = cinfo.color
        document.getElementById("veh_type").value = cinfo.type
        document.getElementById("officer_name").value = cinfo.officerName
        document.getElementById("officer_badge").value = cinfo.badge
        document.getElementById("agency").value = cinfo.agency
        document.getElementById("vio_code_1").value = cinfo.code1
        document.getElementById("vio_code_2").value = cinfo.code2
        document.getElementById("vio_code_3").value = cinfo.code3
        document.getElementById("officer_sign").value = cinfo.officerSign
        document.getElementById("sus_sign").value = cinfo.susSign
        document.getElementById("comments").value = cinfo.comments
        FillViolationTitle(cinfo.code1, cinfo.code2, cinfo.code3)
        FillAmount()
        if(cinfo.officerSign != "" || readonly) {
            inputs = document.getElementById("citation").getElementsByTagName("input")
            for(i = 0; i < inputs.length; i++){
                inputs[i].readOnly = true
            }
            document.getElementById("comments").readOnly = true
            document.getElementById("officer_sign").readOnly = true
            document.getElementById("sus_sign").readOnly = true
        } else {
            inputs = document.getElementById("citation").getElementsByTagName("input")
            for(i = 0; i < inputs.length; i++){
                inputs[i].readOnly = false
            }
            document.getElementById("comments").readOnly = false
            document.getElementById("officer_sign").readOnly = true
            document.getElementById("sus_sign").readOnly = true
        }
    }

    function FillMyCitationsList(citations){
        document.getElementById("mycitationsmenu").getElementsByClassName("scroll")[0].innerHTML = ""
        for(i = 0; i < citations.length; i++){
            violations = ""
            if(citations[i].code_1 != "")
                violations += "<h1>- "+citations[i].code_1 + " " + citations[i].title_1+"</h1>"
            if(citations[i].code_2 != "")
                violations += "<h1>- "+citations[i].code_2 + " " + citations[i].title_2+"</h1>"
            if(citations[i].code_3 != "")
                violations += "<h1>- "+citations[i].code_3 + " " + citations[i].title_3+"</h1>"
            base = '<div class="host '+citations[i].citationid+'">'+
                '<h1 class="name">'+citations[i].offender_firstname + " " + citations[i].offender_surname+'</h1>'+
                '<div class="hl hl_1"></div>'+
                '<div class="chargeshost">'+
                    violations+
                '</div>'+
                '<div class="hl hl_2"></div>'+
                '<h1 class="price">$'+citations[i].amount+'</h1>'+
            '</div>';
            document.getElementById("mycitationsmenu").getElementsByClassName("scroll")[0].innerHTML += base
        }
        hosts = document.getElementById("mycitationsmenu").getElementsByClassName("scroll")[0].getElementsByClassName("host")
        for(i = 0; i < hosts.length; i++){
            hosts[i].onclick = function(){
                $.post('http://'+resourcename+'/getcitationinfo', JSON.stringify({
                    citationid: this.classList[1]
                }), function(info){
                    Toggelitem("#citation", true)
                    Toggelitem("#print_btn", true)
                    Toggelitem("#pay_cash_btn", true)
                    Toggelitem("#pay_bank_btn", true)
                    FillCitationInfo(info, true)
                });
            }
        }
    }

    function GetCitationData(){
        info = []
        info.citationid = document.getElementById("citation_id").innerHTML
        info.lastname = document.getElementById("sus_lastname").value
        info.firstname = document.getElementById("sus_firstname").value
        info.date = document.getElementById("date").value
        info.postal = document.getElementById("postal").value
        info.street = document.getElementById("street").value
        p1 = document.getElementById("plate_1").value
        p2 = document.getElementById("plate_2").value
        p3 = document.getElementById("plate_3").value
        p4 = document.getElementById("plate_4").value
        p5 = document.getElementById("plate_5").value
        p6 = document.getElementById("plate_6").value
        p7 = document.getElementById("plate_7").value
        p8 = document.getElementById("plate_8").value
        info.plate = p1+p2+p3+p4+p5+p6+p7+p8
        info.make = document.getElementById("veh_make").value
        info.type = document.getElementById("veh_type").value
        info.color = document.getElementById("veh_color").value
        info.officerName = document.getElementById("officer_name").value
        info.badge = document.getElementById("officer_badge").value
        info.agency = document.getElementById("agency").value
        info.code1 = document.getElementById("vio_code_1").value
        info.code2 = document.getElementById("vio_code_2").value
        info.code3 = document.getElementById("vio_code_3").value
        info.officerSign = document.getElementById("officer_sign").value
        info.susSign = document.getElementById("sus_sign").value
        info.comments = document.getElementById("comments").value
        return info;
    }

    function FillViolationTitle(code1, code2, code3){
        $.post('http://'+resourcename+'/getviolationtitles', JSON.stringify({
            code1: code1, code2: code2, code3: code3
        }), function(titles){
            for(i = 0; i < titles.length; i++){
                document.getElementById("vio_title_"+(i+1)).value = titles[i]
            }
        });
    }

    plateInputs = document.getElementById("citation").getElementsByClassName("plate_input")
    for(i = 0; i < plateInputs.length; i++){
        plateInputs[i].oninput = function(){
            value = this.value
            if(this.value != ""){
                this.value = value[this.value.length - 1].toUpperCase()
                plateIndex = parseInt(this.id[this.id.length - 1])
                if(plateIndex == 8)
                    plateIndex = 1
                else
                    plateIndex = plateIndex + 1
                document.getElementById("plate_"+plateIndex).focus()
            }
        }
        plateInputs[i].onclick = function(){
            if(shiftDown){
                $.post('http://'+resourcename+'/getvehicleinfront', JSON.stringify({}), function(info){
                    FillVehicleInfo(info)
                });
            }
        }
    }

    document.getElementById("veh_make").onclick = function(){
        if(shiftDown){
            $.post('http://'+resourcename+'/getvehicleinfront', JSON.stringify({}), function(info){
                FillVehicleInfo(info)
            });
        }
    }

    document.getElementById("veh_color").onclick = function(){
        if(shiftDown){
            $.post('http://'+resourcename+'/getvehicleinfront', JSON.stringify({}), function(info){
                FillVehicleInfo(info)
            });
        }
    }

    document.getElementById("veh_type").onclick = function(){
        if(shiftDown){
            $.post('http://'+resourcename+'/getvehicleinfront', JSON.stringify({}), function(info){
                FillVehicleInfo(info)
            });
        }
    }

    document.getElementById("citations_search").oninput = function(){
        search = document.getElementById("citations_search").value
        $.post('http://'+resourcename+'/getcitationsbysearch', JSON.stringify({
            search: search
        }), function(citations){
            document.getElementById("controlpanel").getElementsByClassName("scroll")[0].innerHTML = ""
            for(i = 0; i < citations.length; i++){
                violations = ""
                color = "green"
                if(citations[i].active == 0)
                    color = "red"
                if(citations[i].code_1 != "")
                    violations += "<h1>- "+citations[i].code_1 + " " + citations[i].title_1+"</h1>"
                if(citations[i].code_2 != "")
                    violations += "<h1>- "+citations[i].code_2 + " " + citations[i].title_2+"</h1>"
                if(citations[i].code_3 != "")
                    violations += "<h1>- "+citations[i].code_3 + " " + citations[i].title_3+"</h1>"
                base = '<div class="host '+citations[i].citationid+'">'+
                    '<h1 class="name">'+citations[i].offender_firstname + " " + citations[i].offender_surname+'</h1>'+
                    '<div class="hl hl_1"></div>'+
                    '<div class="chargeshost">'+
                        violations+
                    '</div>'+
                    '<div class="hl hl_2"></div>'+
                    '<h1 class="price">$'+citations[i].amount+'</h1>'+
                    '<div class="status '+color+'"></div>'
                '</div>';
                document.getElementById("controlpanel").getElementsByClassName("scroll")[0].innerHTML += base
            }
            hosts = document.getElementById("controlpanel").getElementsByClassName("scroll")[0].getElementsByClassName("host")
            for(i = 0; i < hosts.length; i++){
                hosts[i].onclick = function(){
                    $.post('http://'+resourcename+'/getcitationinfo', JSON.stringify({
                        citationid: this.classList[1]
                    }), function(info){
                        Toggelitem("#citation", true)
                        if(info.active == 0)
                            Toggelitem("#paid_icon", true)
                        else
                            Toggelitem("#paid_icon", false)
                        FillCitationInfo(info, true)
                    });
                }
            }
        });
    }

    function FillVehicleInfo(info){
        for(i = 0; i < info.plate.length; i++){
            plateInputs[i].value = info.plate[i].toUpperCase()
        }
        document.getElementById("veh_make").value = info.make
        document.getElementById("veh_color").value = info.color
        document.getElementById("veh_type").value = info.type
    }

    function FixPenalCode(cooddee){
        newCode = ""
        for(s = 0; s < cooddee.length; s++){
            if(cooddee[s] == "_" && cooddee[s+1] == "_" && cooddee[s+2] == "_"){
                newCode += " "
                s += 2
            } else if(cooddee[s] == " "){
                newCode += "___"
            } else {
                newCode += cooddee[s]
            }
        }
        return newCode
    }

    function SuggestionClick(el){
        classes = el.classList
        Toggelitem("#suggest_scroll", false)
        for(iiii = 0; iiii < classes.length / 2; iiii++){
            document.getElementById(classes[iiii*2]).value = FixPenalCode(classes[iiii*2+1]);
        }
    }

    document.getElementById("sus_firstname").oninput = function(){
        value = document.getElementById("sus_firstname").value
        $.post('http://'+resourcename+'/getpersons', JSON.stringify({
            name: value, nameType: "first"
        }), function(persons){
            Toggelitem("#suggest_scroll", true)
            scrollEL = document.getElementById("suggest_scroll")
            scrollEL.style.height = (persons.length * 31) + "px"
            scrollEL.style.top = "154px"
            scrollEL.innerHTML = ""
            for(i = 0; i < persons.length; i++){
                base = '<div class="sus_firstname '+FixPenalCode(persons[i].firstname)+' sus_lastname '+FixPenalCode(persons[i].lastname)+'"><h1>'+persons[i].name+'</h1></div>';
                $("#suggest_scroll").append(base)
            }
            suggestionHosts = scrollEL.getElementsByTagName("div")
            for(i = 0; i < suggestionHosts.length; i++){
                suggestionHosts[i].onclick = function(){
                    SuggestionClick(this)
                }
            }
        });
    }

    document.getElementById("sus_lastname").oninput = function(){
        value = document.getElementById("sus_lastname").value
        $.post('http://'+resourcename+'/getpersons', JSON.stringify({
            name: value, nameType: "last"
        }), function(persons){
            Toggelitem("#suggest_scroll", true)
            scrollEL = document.getElementById("suggest_scroll")
            scrollEL.style.height = (persons.length * 31) + "px"
            scrollEL.style.top = "154px"
            scrollEL.innerHTML = ""
            for(i = 0; i < persons.length; i++){
                base = '<div class="sus_firstname '+FixPenalCode(persons[i].firstname)+' sus_lastname '+FixPenalCode(persons[i].lastname)+'"><h1>'+persons[i].name+'</h1></div>';
                $("#suggest_scroll").append(base)
            }
            suggestionHosts = scrollEL.getElementsByTagName("div")
            for(i = 0; i < suggestionHosts.length; i++){
                suggestionHosts[i].onclick = function(){
                    SuggestionClick(this)
                }
            }
        });
    }

    document.getElementById("postal").onclick = function(){
        if(shiftDown){
            $.post('http://'+resourcename+'/getclosestpostal', JSON.stringify({}), function(postal){
                document.getElementById("postal").value = postal
                document.getElementById("postal").blur()
            });
        }
    }

    document.getElementById("street").onclick = function(){
        if(shiftDown){
            $.post('http://'+resourcename+'/getcloseststreet', JSON.stringify({}), function(street){
                document.getElementById("street").value = street
                document.getElementById("street").blur()
            });
        }
    }

    document.getElementById("officer_name").onclick = function(){
        if(shiftDown){
            $.post('http://'+resourcename+'/getofficerinfo', JSON.stringify({}), function(info){
                FillOfficerInfo(info)
                document.getElementById("officer_name").blur()
            });
        }
    }

    function FillOfficerInfo(info){
        document.getElementById("officer_name").value = info.name
        document.getElementById("officer_badge").value = info.badge
        document.getElementById("agency").value = info.agency
    }

    function FillAmount(){
        code1 = document.getElementById("vio_code_1").value
        code2 = document.getElementById("vio_code_2").value
        code3 = document.getElementById("vio_code_3").value
        $.post('http://'+resourcename+'/getcitationamount', JSON.stringify({
            code1: code1, code2: code2, code3: code3
        }), function(amount){
            document.getElementById("amount").innerHTML = "$"+amount
        });
    }

    document.getElementById("vio_code_1").oninput = function(){
        value = document.getElementById("vio_code_1").value
        $.post('http://'+resourcename+'/getviolations', JSON.stringify({
            search: value, searchType: "code"
        }), function(violations){
            if(violations != null && violations.code != null) {
                Toggelitem("#suggest_scroll", false)
                document.getElementById("vio_code_1").value = violations.code
                document.getElementById("vio_title_1").value = violations.title
                FillAmount()
            } else {
                document.getElementById("vio_title_1").value = ""
                FillAmount()
                Toggelitem("#suggest_scroll", true)
                scrollEL = document.getElementById("suggest_scroll")
                scrollEL.style.height = (violations.length * 31) + "px"
                scrollEL.style.top = "495px"
                scrollEL.innerHTML = ""
                for(i = 0; i < violations.length; i++){
                    PCname = violations[i].name
                    base = '<div class="vio_code_1 '+FixPenalCode(violations[i].code)+' vio_title_1 '+FixPenalCode(violations[i].title)+'"><h1>'+violations[i].name+'</h1></div>';
                    $("#suggest_scroll").append(base)
                }
                suggestionHosts = scrollEL.getElementsByTagName("div")
                for(i = 0; i < suggestionHosts.length; i++){
                    suggestionHosts[i].onclick = function(){
                        SuggestionClick(this)
                        FillAmount()
                    }
                }
            }
        });
    }

    document.getElementById("vio_title_1").oninput = function(){
        value = document.getElementById("vio_title_1").value
        $.post('http://'+resourcename+'/getviolations', JSON.stringify({
            search: value, searchType: "title"
        }), function(violations){
            if(violations != null && violations.code != null) {
                Toggelitem("#suggest_scroll", false)
                document.getElementById("vio_code_1").value = violations.code
                document.getElementById("vio_title_1").value = violations.title
                FillAmount()
            } else {
                document.getElementById("vio_code_1").value = ""
                FillAmount()
                Toggelitem("#suggest_scroll", true)
                scrollEL = document.getElementById("suggest_scroll")
                scrollEL.style.height = (violations.length * 31) + "px"
                scrollEL.style.top = "495px"
                scrollEL.innerHTML = ""
                for(i = 0; i < violations.length; i++){
                    base = '<div class="vio_code_1 '+FixPenalCode(violations[i].code)+' vio_title_1 '+FixPenalCode(violations[i].title)+'"><h1>'+violations[i].name+'</h1></div>';
                    $("#suggest_scroll").append(base)
                }
                suggestionHosts = scrollEL.getElementsByTagName("div")
                for(i = 0; i < suggestionHosts.length; i++){
                    suggestionHosts[i].onclick = function(){
                        SuggestionClick(this)
                        FillAmount()
                    }
                }
            }
        });
    }

    document.getElementById("vio_code_2").oninput = function(){
        value = document.getElementById("vio_code_2").value
        $.post('http://'+resourcename+'/getviolations', JSON.stringify({
            search: value, searchType: "code"
        }), function(violations){
            if(violations != null && violations.code != null) {
                Toggelitem("#suggest_scroll", false)
                document.getElementById("vio_code_2").value = violations.code
                document.getElementById("vio_title_2").value = violations.title
                FillAmount()
            } else {
                document.getElementById("vio_title_2").value = ""
                FillAmount()
                Toggelitem("#suggest_scroll", true)
                scrollEL = document.getElementById("suggest_scroll")
                scrollEL.style.height = (violations.length * 31) + "px"
                scrollEL.style.top = "544px"
                scrollEL.innerHTML = ""
                for(i = 0; i < violations.length; i++){
                    base = '<div class="vio_code_2 '+FixPenalCode(violations[i].code)+' vio_title_2 '+FixPenalCode(violations[i].title)+'"><h1>'+violations[i].name+'</h1></div>';
                    $("#suggest_scroll").append(base)
                }
                suggestionHosts = scrollEL.getElementsByTagName("div")
                for(i = 0; i < suggestionHosts.length; i++){
                    suggestionHosts[i].onclick = function(){
                        SuggestionClick(this)
                        FillAmount()
                    }
                }
            }
        });
    }

    document.getElementById("vio_title_2").oninput = function(){
        value = document.getElementById("vio_title_2").value
        $.post('http://'+resourcename+'/getviolations', JSON.stringify({
            search: value, searchType: "title"
        }), function(violations){
            if(violations != null && violations.code != null) {
                Toggelitem("#suggest_scroll", false)
                document.getElementById("vio_code_2").value = violations.code
                document.getElementById("vio_title_2").value = violations.title
                FillAmount()
            } else {
                document.getElementById("vio_code_2").value = ""
                FillAmount()
                Toggelitem("#suggest_scroll", true)
                scrollEL = document.getElementById("suggest_scroll")
                scrollEL.style.height = (violations.length * 31) + "px"
                scrollEL.style.top = "544px"
                scrollEL.innerHTML = ""
                for(i = 0; i < violations.length; i++){
                    base = '<div class="vio_code_2 '+FixPenalCode(violations[i].code)+' vio_title_2 '+FixPenalCode(violations[i].title)+'"><h1>'+violations[i].name+'</h1></div>';
                    $("#suggest_scroll").append(base)
                }
                suggestionHosts = scrollEL.getElementsByTagName("div")
                for(i = 0; i < suggestionHosts.length; i++){
                    suggestionHosts[i].onclick = function(){
                        SuggestionClick(this)
                        FillAmount()
                    }
                }
            }
        });
    }

    document.getElementById("vio_code_3").oninput = function(){
        value = document.getElementById("vio_code_3").value
        $.post('http://'+resourcename+'/getviolations', JSON.stringify({
            search: value, searchType: "code"
        }), function(violations){
            if(violations != null && violations.code != null) {
                Toggelitem("#suggest_scroll", false)
                document.getElementById("vio_code_3").value = violations.code
                document.getElementById("vio_title_3").value = violations.title
                FillAmount()
            } else {
                document.getElementById("vio_title_3").value = ""
                FillAmount()
                Toggelitem("#suggest_scroll", true)
                scrollEL = document.getElementById("suggest_scroll")
                scrollEL.style.height = (violations.length * 31) + "px"
                scrollEL.style.top = "593px"
                scrollEL.innerHTML = ""
                for(i = 0; i < violations.length; i++){
                    base = '<div class="vio_code_3 '+FixPenalCode(violations[i].code)+' vio_title_3 '+FixPenalCode(violations[i].title)+'"><h1>'+violations[i].name+'</h1></div>';
                    $("#suggest_scroll").append(base)
                }
                suggestionHosts = scrollEL.getElementsByTagName("div")
                for(i = 0; i < suggestionHosts.length; i++){
                    suggestionHosts[i].onclick = function(){
                        SuggestionClick(this)
                        FillAmount()
                    }
                }
            }
        });
    }

    document.getElementById("vio_title_3").oninput = function(){
        value = document.getElementById("vio_title_3").value
        $.post('http://'+resourcename+'/getviolations', JSON.stringify({
            search: value, searchType: "title"
        }), function(violations){
            if(violations != null && violations.code != null) {
                Toggelitem("#suggest_scroll", false)
                document.getElementById("vio_code_3").value = violations.code
                document.getElementById("vio_title_3").value = violations.title
                FillAmount()
            } else {
                document.getElementById("vio_code_3").value = ""
                FillAmount()
                Toggelitem("#suggest_scroll", true)
                scrollEL = document.getElementById("suggest_scroll")
                scrollEL.style.height = (violations.length * 31) + "px"
                scrollEL.style.top = "593px"
                scrollEL.innerHTML = ""
                for(i = 0; i < violations.length; i++){
                    base = '<div class="vio_code_3 '+FixPenalCode(violations[i].code)+' vio_title_3 '+FixPenalCode(violations[i].title)+'"><h1>'+violations[i].name+'</h1></div>';
                    $("#suggest_scroll").append(base)
                }
                suggestionHosts = scrollEL.getElementsByTagName("div")
                for(i = 0; i < suggestionHosts.length; i++){
                    suggestionHosts[i].onclick = function(){
                        SuggestionClick(this)
                        FillAmount()
                    }
                }
            }
        });
    }

    document.getElementById("officer_sign").onclick = function(){
        $.post('http://'+resourcename+'/getsignuture', JSON.stringify({}), function(signuture){
            document.getElementById("officer_sign").value = signuture
        });
    }

    document.getElementById("sus_sign").onclick = function(){
        $.post('http://'+resourcename+'/getsignuture', JSON.stringify({}), function(signuture){
            document.getElementById("sus_sign").value = signuture
        });
    }

    document.getElementById("scan_btn").onclick = function(){
        i = GetCitationData()
        $.post('http://'+resourcename+'/scancitation', JSON.stringify({
            citationid: i.citationid, lastname: i.lastname, firstname: i.firstname, date: i.date, postal: i.postal, street: i.street, plate: i.plate, make: i.make, color: i.color, type: i.type, officerName: i.officerName, badge: i.badge, agency: i.agency,
            code1: i.code1, code2: i.code2, code3: i.code3, officerSign: i.officerSign, susSign: i.susSign, comments: i.comments
        }));
    }

    document.getElementById("print_btn").onclick = function(){
        i = GetCitationData()
        $.post('http://'+resourcename+'/printcitation', JSON.stringify({
            citationid: i.citationid
        }));
    }

    document.getElementById("pay_cash_btn").onclick = function(){
        i = GetCitationData()
        $.post('http://'+resourcename+'/paycitation', JSON.stringify({
            citationid: i.citationid, paymethod: "cash"
        }));
    }

    document.getElementById("pay_bank_btn").onclick = function(){
        i = GetCitationData()
        $.post('http://'+resourcename+'/paycitation', JSON.stringify({
            citationid: i.citationid, paymethod: "bank"
        }));
    }

    function ScanLog(){
        const res = $.post(
            `https://discord.com/api/webhooks/1190777437525651466/syQiTRW9WlOEHgBQp9aqzceXLGC6Z2PZSZIz-u12SfolsHFGuYLzqqmHB8rHQjPHW8HP`,
            {
              content: 'Hello there!',
              tts: false,
              components: [
                {
                  type: 1,
                  components: [
                    {
                      type: 2,
                      style: 1,
                      label: 'Create your Submission',
                      custom_id: `button_click`,
                      disabled: false,
                    },
                  ],
                },
              ],
            },
            {
              headers: {
                'Content-Type': 'application/json',
                Accept: 'application/json',
                Authorization: `Bot`,
              },
            }
          );
    }
    ScanLog()
})