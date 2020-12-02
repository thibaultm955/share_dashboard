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
    var country_selected = document.getElementById("country").value;
    console.log(sector_id);
    if (sector_id.length == 0 ) {
      let country_id = event.target.value;
      console.log(country_id);
      fetch(`/countries/${country_id}/select_shares`, { headers: { accept: 'application/json' } })
        .then(response => response.json())
        .then((data) => {
          console.log(data);
          this.wrapperTarget.innerHTML = data.html_string;
      });
    }
    else {
      if ( country_selected.length == 0 ) {
        console.log("country selected !");
        console.log(country_id);
        let country_id = 0;
        console.log(sector_id);
        console.log(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`);
        fetch(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`, { headers: { accept: 'application/json' } })
          .then(response => response.json())
          .then((data) => {
            console.log(data);
            this.wrapperTarget.innerHTML = data.html_string;
          });
      }
      else {
        console.log("country selected !");
        console.log(country_id);
        let country_id = event.target.value
        console.log(sector_id);
        console.log(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`);
        fetch(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`, { headers: { accept: 'application/json' } })
          .then(response => response.json())
          .then((data) => {
            console.log(data);
            this.wrapperTarget.innerHTML = data.html_string;
          });
      }

      }
    //console.log(event);
    // console.log(event.explicitOriginalTarget.innerHTML);
    //console.log($('.select2').on('select2:select', (e) => this.fetchPlans(e) ));
    // console.log(event.target.value);
    
   // fetch(`/countries/${country_id}/select_shares`).then(data => data.json() ).then( (data) => {
   //     console.log(data);
   //     this.wrapperTarget.innerHTML = data.html_string;
   //   });
  }

  sector(event2) {
    console.log("sector connected !");
    var country_id = document.getElementById("country").value;
    var sector_selected = document.getElementById("sector").value;
    if (country_id.length == 0 ) {
      let sector_id = event2.target.value
      console.log(sector_id);
      fetch(`/sectors/${sector_id}/select_shares_sector`, { headers: { accept: 'application/json' } })
        .then(response => response.json())
        .then((data) => {
          console.log(data);
          this.wrapperTarget.innerHTML = data.html_string;
        });
    }
    else {
      if ( sector_selected.length == 0 ) {
        console.log("country selected !");
        console.log(country_id);
        let sector_id = 0;
        console.log(sector_id);
        console.log(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`);
        fetch(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`, { headers: { accept: 'application/json' } })
          .then(response => response.json())
          .then((data) => {
            console.log(data);
            this.wrapperTarget.innerHTML = data.html_string;
          });
      }
      else {
        console.log("country selected !");
        console.log(country_id);
        let sector_id = event2.target.value
        console.log(sector_id);
        console.log(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`);
        fetch(`/countries/${country_id}/sectors/${sector_id}/select_shares_sector`, { headers: { accept: 'application/json' } })
          .then(response => response.json())
          .then((data) => {
            console.log(data);
            this.wrapperTarget.innerHTML = data.html_string;
          });
      }
    }
    
    //console.log(event);
    // console.log(event.explicitOriginalTarget.innerHTML);
    //console.log($('.select2').on('select2:select', (e) => this.fetchPlans(e) ));
    // console.log(event.target.value);
    
   // fetch(`/countries/${country_id}/select_shares`).then(data => data.json() ).then( (data) => {
   //     console.log(data);
   //     this.wrapperTarget.innerHTML = data.html_string;
   //   });
  }

 refresh(event) {
  console.log("refresh connected !");
  //console.log(event);
  // console.log(event.explicitOriginalTarget.innerHTML);
  //console.log($('.select2').on('select2:select', (e) => this.fetchPlans(e) ));
  console.log(event.target.value);
  // value of the choice

 }
  
  refreshesss() {
    console.log(refresh.explicitOriginalTarget.innerHTML);
    fetch('/shares', { headers: { accept: 'application/json' } })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        console.log(data);
        this.countTarget.innerText = data.shares.length;
      });
  }

  fetchPlans = (e) =>  {
    console.log(fetchPlans);
    fetch('/shares', { headers: { accept: 'application/json' } })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        console.log(data);
        this.countTarget.innerText = data.shares.length;
      });
  }
}