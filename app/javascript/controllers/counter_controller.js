import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'count', 'wrapper' ];
  

  connect() {
    console.log("controller connected !");
    $('.select2').on('select2:select', (e) => this.fetchPlans(e) );
    var x = document.getElementById("country");
    console.log(x.value);
 }

  country(event) {
    console.log("country connected !");
    var sector_id = document.getElementById("sector").value;
    var country_id = document.getElementById("country").value;
    console.log(sector_id);
    if (sector_id.length == 0 && country_id.length == 0) {
      var sector_id = "none";
      var country_id = "none";
      console.log(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`);
      fetch(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`, { headers: { accept: 'application/json' } })
        .then(response => response.json())
        .then((data) => {
          console.log(data);
          this.wrapperTarget.innerHTML = data.html_string;
      });
    }
    else if (sector_id.length == 0) {
      var sector_id = "none";
      console.log(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`);
      fetch(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`, { headers: { accept: 'application/json' } })
        .then(response => response.json())
        .then((data) => {
          console.log(data);
          this.wrapperTarget.innerHTML = data.html_string;
      });
    }
    else if (country_id.length == 0) {
      var country_id = "none";
      console.log(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`);
      fetch(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`, { headers: { accept: 'application/json' } })
        .then(response => response.json())
        .then((data) => {
          console.log(data);
          this.wrapperTarget.innerHTML = data.html_string;
      });
    }
    else {
      console.log(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`);
      fetch(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`, { headers: { accept: 'application/json' } })
        .then(response => response.json())
        .then((data) => {
          console.log(data);
          this.wrapperTarget.innerHTML = data.html_string;
      });
      }

    }
  }