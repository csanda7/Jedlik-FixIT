<template>
  <div class="container mt-2 align-center">
    <div class="card p-4 shadow">
      <h1 class="text-center my-2">HIBA BEJELENTÉSE</h1>
        <div class="my-3">
          <label for="bugName" class="form-label">Hiba megnevezése</label>
          <input type="text" class="form-control" id="bugName" v-model="bugName" placeholder="Adja meg a hiba nevét röviden">
        </div>
        <div class="mb-3">
          <label for="bugDescription" class="form-label">Hiba leírása</label>
          <textarea class="form-control" id="bugDescription" v-model="bugDescription" rows="3" placeholder="Adja meg a hiba leírását"></textarea>
        </div>

        <div class="row">
          <div class="col-md-6 my-3">
        <button class="btn dropdown-toggle w-100 mx-2  my-2" style="border: 2px solid gray;" type="button" id="location" data-bs-toggle="dropdown" aria-expanded="false">
              Helyszín
        </button>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton2">
          <li><a class="dropdown-item text-center" href="#">Első terem</a></li>
          <li><a class="dropdown-item text-center" href="#">Másik terem 2</a></li>
          <li><a class="dropdown-item text-center" href="#">Másik terem 3</a></li>
          <li><a class="dropdown-item text-center" href="#">Egyéb</a></li>
        </ul></div>


        <div class="col-md-6 my-3 ">
        <button class="btn dropdown-toggle w-100  mx-2 my-2" style="border: 2px solid gray;" type="button" id="tag" data-bs-toggle="dropdown" aria-expanded="false">
              Címkék
        </button>
        <ul class="dropdown-menu dropdown-menu-end " aria-labelledby="dropdownMenuButton2">
          <li><a class="dropdown-item text-center" href="#">Hardver</a></li>
          <li><a class="dropdown-item text-center" href="#">Szoftver</a></li>
          <li><a class="dropdown-item text-center" href="#">Egyéb</a></li>
        </ul>
      </div>
      </div>

        <div class="row">
          <!-- First column for the priority input -->
          <div class="col-md-6 my-3">
            <label for="priority" class="form-label">Prioritás: {{ priority }}</label>
            <input type="range" class="form-range" min="0" max="5" v-model="priority" id="priority">
          </div>

          <!-- Second column for the photo upload input -->
          <div class="col-md-6 my-3">
            <label for="photo" class="form-label">Fotó feltöltése</label>
            <input type="file" class="form-control" id="photo" @change="onFileChange">
          </div>


</div>


        <div class="d-grid gap-2 d-flex justify-content-center my-3">
          <button type="button" class="btn btn-secondary w-100" @click="goBack">Vissza</button>
          <button type="submit" class="btn btn-primary w-100" @click="bekuldes" >Hiba beküldése</button>
        </div>
    </div>
  </div>
</template>
  
  <script>

  import axios from 'axios';
  export default {
    data() {
      return {
        bugName: '',
        priority: 0,
        bugDescription: '',
        photo: null,
        location: '',
        tag: ''
      };
    },

    methods: {
      onFileChange(event) {
        this.photo = event.target.files[0];
      },
      bekuldes: function() {
  const username = localStorage.getItem('Name')
  const formData = new FormData();
  formData.append('bugName', this.bugName);
  formData.append('priority', this.priority);
  formData.append('bugDescription', this.bugDescription);
  formData.append('location', this.location);
  formData.append('label', this.tag);
  formData.append('reported_by', username);
  if (this.photo) {
    formData.append('photo', this.photo); // Attach the photo
  }

  axios.post("http://localhost:4500/api/bugReport", formData, {
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
  .then((res) => {
    if (res.data.msg === "Validation Failed") {
      let errors = res.data.errors;
      let errorMsg = "";
      if (errors.bugName) {
        errorMsg += errors.bugName.join("\n");
      }
      if (errors.priority) {
        errorMsg += errors.priority.join("\n");
      }
      if (errors.bugDescription) {
        errorMsg += errors.bugDescription.join("\n");
      }
      if (errors.location) {
        errorMsg += errors.location.join("\n");
      }
      if (errors.tag) {
        errorMsg += errors.tag.join("\n");
      }
      alert(errorMsg);
    } else {
      alert("Successfully Saved");
    }
  })
  .catch((error) => {
    console.error("Error submitting bug report:", error);
    alert("Something Went Wrong");
  });
}},


      goBack() {
        console.log("Going back...");
      }};
  </script>
  
  <style scoped>
  .card {
    max-width: 600px;
    margin: 0 auto; /* Center align */
  }
  
  .form-range {
    width: 100%;
  }
  
  .btn-primary {
    background-color: #4285f4;
    border-color: #4285f4;
  }
  
  .btn-secondary {
    background-color: #6c757d;
  }
  </style>
  