import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'count', 'wrapper' ];

  connect() {
    console.log("controller connected !");
    $('.select2').on('select2:select', (e) => this.fetchPlans(e) );
 }

  country(event) {
    console.log("country connected !");
    //console.log(event);
    // console.log(event.explicitOriginalTarget.innerHTML);
    //console.log($('.select2').on('select2:select', (e) => this.fetchPlans(e) ));
    // console.log(event.target.value);
    let country_id = event.target.value
    console.log(country_id);
    fetch(`/countries/${country_id}/select_shares`, { headers: { accept: 'application/json' } })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        this.countTarget.innerText = data.shares.length;
      });
    fetch(`/countries/${country_id}/select_shares`).then(data => data.json() ).then( (data) => {
          console.log(data);
          this.wrapperTarget.innerHTML = data.html_string;
        });
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