$(document).ready(function () {
  window.addEventListener("message", function (event) {
    var item = event.data;

    if (!item || (!item.display && !item.action)) return;

    if (item.display == "viewRegistration") {
      $("#name-registration").text(item.citizenName || "Desconhecido");
      $("#plate-registration").text(item.registeredPLate || "Não especificado");
      $("#model-registration").text(item.vehicleMModel || "Não especificado");
      $("#expire-registration").text(item.registrationExpire || "Sem validade");

      $("#vehiclerc").fadeIn();

    } else if (item.display == "viewInsurance") {
      $("#name-insurance").text(item.citizenName || "Desconhecido");
      $("#plate-insurance").text(item.registeredPLate || "Não especificado");
      $("#model-insurance").text(item.vehicleMModel || "Não especificado");
      $("#expire-insurance").text(item.registrationExpire || "Sem validade");
  
      $("#vehicleinsurance").fadeIn(); 
       
    } else if (item.display == "viewHealthInsurance") {
      $("#name-healthinsurance").text(item.citizenName || "N/A");
      $("#expire-healthinsurance").text(item.insuranceExpire || "Sem validade");

      $("#healthinsurance").fadeIn();
    } else if (item.display == "viewHomeInsurance") {
      $("#name-homeinsurance").text(item.citizenName || "Desconhecido");
      $("#expire-homeinsurance").text(item.insuranceExpire || "Sem validade");

      $("#homeinsurance").fadeIn();
    } else if (item.action == "close") {
      $("#vehiclerc").fadeOut();
      $("#vehicleinsurance").fadeOut();
      $("#healthinsurance").fadeOut();
      $("#homeinsurance").fadeOut();

      $("#conditional").hide();
    }
  });
});

