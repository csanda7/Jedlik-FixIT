<template>
  <div class="container mt-5">
    <div class="card p-4 shadow mx-auto" style="max-width: 600px;">
      <h1 class="text-center my-2">HIBA BEJELENTÉSE</h1>

      <!-- Pop-Up Message -->
      <div v-if="showPopup" class="alert alert-danger" role="alert">
        Kérjük, töltse ki az összes kötelező mezőt!
      </div>

      <div class="my-3">
        <label for="bugName" class="form-label">Hiba megnevezése <span class="text-danger">*</span></label>
        <input type="text" class="form-control" id="bugName" v-model="bugName" placeholder="Adja meg a hiba nevét röviden" required>
      </div>

      <div class="mb-3">
        <label for="bugDescription" class="form-label">Hiba leírása <span class="text-danger">*</span></label>
        <textarea class="form-control" id="bugDescription" v-model="bugDescription" rows="3" placeholder="Adja meg a hiba leírását" maxlength="300" @input="adjustTextareaHeight($event)" required></textarea>
      </div>

      <div class="row ">
        <div class="col-md-6  my-1">
          <div class="dropdown">
            <button class="btn dropdown-toggle w-100 my-2" style="border: 2px solid gray;" type="button" id="locationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
              {{ location || 'Helyszín' }} <span class="text-danger" v-if="!location">*</span>
            </button>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="locationDropdown">
              <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Első terem')">Első terem</a></li>
              <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Másik terem 2')">Másik terem 2</a></li>
              <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Másik terem 3')">Másik terem 3</a></li>
              <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Egyéb')">Egyéb</a></li>
            </ul>
          </div>
        </div>
      </div>

      <div class="row ">
        <div v-if="showOtherLocation" class="col-sm-12 col-md-6 my-3 mt-0">
          <input type="text" class="form-control border-secondary" id="otherLocation" v-model="otherLocation" placeholder="Adja meg a helyszínt">
        </div>
        <div class="col-sm-0 col-md-6"></div>
      </div>
      <div class="row   ">
      <div class="col-md-6 my-1">
          <div class="dropdown">
            <button class="btn dropdown-toggle w-100 my-2" style="border: 2px solid gray;" type="button" id="labelDropdown" data-bs-toggle="dropdown" aria-expanded="false">
              {{ label || 'Címkék' }} <span class="text-danger" v-if="!label">*</span>
            </button>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="labelDropdown">
              <li><a class="dropdown-item text-center" href="#" @click="selectlabel('Hardver')">Hardver</a></li>
              <li><a class="dropdown-item text-center" href="#" @click="selectlabel('Szoftver')">Szoftver</a></li>
              <li><a class="dropdown-item text-center" href="#" @click="selectlabel('Egyéb')">Egyéb</a></li>
            </ul>
          </div>
        </div>
      </div>

      <div class="row mx-0">
        <div class="col-md-6 my-3">
          <label for="priority" class="form-label">Prioritás:</label>
          <div class="d-flex flex-row">
            <div class="form-check me-2">
              <input class="form-check-input" type="radio" v-model="priority" id="priority0" value="0" />
              <label class="form-check-label" for="priority0" data-bs-toggle="tooltip" data-bs-placement="top" title="Nincs megadva prioritás">Nincs</label>
            </div>
            <div class="form-check me-2" v-for="n in 5" :key="n">
              <input class="form-check-input" type="radio" v-model="priority" :id="'priority' + n" :value="n" />
              <label class="form-check-label" :for="'priority' + n">{{ n }}</label>
            </div>
          </div>
        </div>

        <div class="col-md-6 my-3">
          <label for="photo" class="form-label">Fotók feltöltése</label>
          <input type="file" class="form-control" id="photo" @change="onFileChange" accept=".png, .jpg, .jpeg, .heic" multiple>
        </div>
      </div>

      <div class="d-grid gap-2 d-flex justify-content-center my-3">
        <button type="button" class="btn btn-secondary w-100" @click="reset">Adatok törlése</button>
        <button type="submit" class="btn btn-primary w-100" @click="bekuldes">Hiba beküldése</button>
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
      priority: '0',
      bugDescription: '',
      photos: [],
      location: '',
      label: '',
      showOtherLocation: false,
      otherLocation: '',
      showPopup: false, // State for the popup message
    };
  },
  methods: {
    onFileChange(event) {
      const files = event.target.files;
      if (files.length + this.photos.length > 3) {
        alert('Maximum 3 képet tölthet fel.');
        return;
      }
      for (let i = 0; i < files.length; i++) {
        this.photos.push(files[i]);
      }
    },
    reset() {
      this.bugName = '';
      this.priority = '0';
      this.bugDescription = '';
      this.photos = [];
      this.location = '';
      this.label = '';
      this.showOtherLocation = false;
      this.otherLocation = '';
      this.showPopup = false; // Reset the popup on reset
    },
    adjustTextareaHeight(event) {
      const textarea = event.target;
      textarea.style.height = 'auto'; // Reset height to auto to correctly calculate the new height
      textarea.style.height = textarea.scrollHeight + 'px'; // Set height based on scroll height
    },
    selectLocation(selectedLocation) {
      this.location = selectedLocation;
      this.showOtherLocation = selectedLocation === 'Egyéb';
    },
    selectlabel(selectedlabel) {
      this.label = selectedlabel;
    },
    bekuldes() {
      // Validate required fields
      if (!this.bugName || !this.bugDescription || !this.location || !this.label) {
        this.showPopup = true; // Show popup if any required fields are empty
        return;
      }

      const username = sessionStorage.getItem('username'); // Get the username from sessionStorage

      if (!username) {
        alert('No user logged in');
        return;
      }

      const formData = new FormData();
      formData.append('bugName', this.bugName);
      formData.append('priority', this.priority);
      formData.append('bugDescription', this.bugDescription);
      formData.append('location', this.location === 'Egyéb' ? this.otherLocation : this.location);
      formData.append('label', this.label);
      formData.append('reported_by', username);

      // Append each photo to the FormData
      this.photos.forEach((photo, index) => {
        formData.append(`photo${index}`, photo); // Key with index (photo0, photo1, photo2)
      });

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
            if (errors.label) {
              errorMsg += errors.label.join("\n");
            }
            alert(errorMsg);
          } else {
            alert("Hiba sikeresen elküldve");
          }
        });
    }
  }
};
</script>

<style scoped>
.card {
  max-width: 600px;
  margin: 0 auto;
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
