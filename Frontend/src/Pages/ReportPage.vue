<template>
  <div :class="['container', 'mt-5', isDarkMode ? 'dark-mode' : 'light-mode']">
    <div class="card p-4 shadow mx-auto" style="max-width: 600px;">
      <h1 class="text-center my-2">HIBA BEJELENTÉSE</h1>

      <!-- Pop-Up Message -->
      <div v-if="showPopup" class="alert alert-danger" role="alert">
        Kérjük, töltse ki az összes kötelező mezőt!
      </div>

      <div class="my-3">
        <label for="bugName" class="form-label">Hiba megnevezése <span class="text-danger">*</span></label>
        <input 
          type="text" 
          :class="['form-control', isDarkMode ? 'dark-textbox' : '']"
          id="bugName" 
          v-model="bugName" 
          placeholder="Adja meg a hiba nevét röviden" 
          required 
          @input="setCookie('bugName', bugName)">
      </div>

      <div class="mb-3">
        <label for="bugDescription" class="form-label">Hiba leírása <span class="text-danger">*</span></label>
        <textarea 
          :class="['form-control', isDarkMode ? 'dark-textbox' : '']" 
          id="bugDescription" 
          v-model="bugDescription" 
          rows="3" 
          placeholder="Adja meg a hiba leírását" 
          maxlength="300" 
          @input="adjustTextareaHeight($event); setCookie('bugDescription', bugDescription);" 
          required>
        </textarea>
      </div>

      <div class="row">
        <div class="col-md-6 my-1">
          <div class="dropdown">
            <button 
              :class="['btn dropdown-toggle w-100 my-2', isDarkMode ? 'dark-dropdown' : '']" 
              type="button" 
              id="locationDropdown" 
              data-bs-toggle="dropdown" 
              aria-expanded="false">
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
  <input type="text" :class="['form-control border-secondary', isDarkMode ? 'dark-textbox' : '']" id="otherLocation" v-model="otherLocation" placeholder="Adja meg a helyszínt" 
    @input="setCookie('otherLocation', otherLocation)">
    </div>

      </div>
      <div class="row ">
  <div class="col-md-6 my-1">
    <div class="dropdown">
      <button 
        :class="['btn dropdown-toggle w-100 my-2', isDarkMode ? 'dark-dropdown' : '']" 
        type="button" 
        id="labelDropdown" 
        data-bs-toggle="dropdown" 
        aria-expanded="false">
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
              <input class="form-check-input" type="radio" v-model="priority" id="priority0" value="0" @change="setCookie('priority', priority)" />
              <label class="form-check-label" for="priority0" data-bs-toggle="tooltip" data-bs-placement="top" title="Nincs megadva prioritás">Nincs</label>
            </div>
            <div class="form-check me-2" v-for="n in 5" :key="n">
              <input class="form-check-input" type="radio" v-model="priority" :id="'priority' + n" :value="n" @change="setCookie('priority', priority)" />
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
      bugName: this.getCookie('bugName') || '',
      priority: this.getCookie('priority') || '0',
      bugDescription: this.getCookie('bugDescription') || '',
      photos: [],
      location: this.getCookie('location') || '',
      label: this.getCookie('label') || '',
      showOtherLocation: false,
      otherLocation: this.getCookie('otherLocation') || '',
      showPopup: false, // State for the popup message
      isDarkMode: false,
    };
  },

  mounted() {
    this.isDarkMode = localStorage.getItem('theme') === 'dark';
    window.addEventListener('theme-changed', this.updateTheme);
  },
  beforeDestroy() {
    window.removeEventListener('theme-changed', this.updateTheme);
  },
  methods: {

    
    setCookie(name, value, days = 7) {
      const d = new Date();
      d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
      const expires = "expires=" + d.toUTCString();
      document.cookie = name + "=" + value + ";" + expires + ";path=/";
    },
    getCookie(name) {
      const nameEQ = name + "=";
      const ca = document.cookie.split(';');
      for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
      }
      return '';
    },
    onFileChange(event) {
      const files = event.target.files;
      if (files.length + this.photos.length > 4) {
        alert('Maximum 4 képet tölthet fel.');
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

      // Clear cookies
      this.setCookie('bugName', '');
      this.setCookie('priority', '0');
      this.setCookie('bugDescription', '');
      this.setCookie('location', '');
      this.setCookie('label', '');
      this.setCookie('otherLocation', '');
    },
    updateTheme() {
      this.isDarkMode = localStorage.getItem('theme') === 'dark';
    },
    adjustTextareaHeight(event) {
      const textarea = event.target;
      textarea.style.height = 'auto'; // Reset height to auto to correctly calculate the new height
      textarea.style.height = textarea.scrollHeight + 'px'; // Set height based on scroll height
    },
    selectLocation(selectedLocation) {
      this.location = selectedLocation;
      this.showOtherLocation = selectedLocation === 'Egyéb';
      this.setCookie('location', selectedLocation);
    },
    selectlabel(selectedlabel) {
      this.label = selectedlabel;
      this.setCookie('label', selectedlabel);
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
      formData.append('bugDescription', this.bugDescription);
      formData.append('reported_by', username);
      formData.append('location', this.location);
      formData.append('priority', this.priority);

      // Debugging line for label
      console.log('Label:', this.label);
      formData.append('label', this.label);

      // Append photos to formData
      this.photos.forEach(photo => {
        formData.append('photos', photo);
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
          this.reset(); // Optionally reset form after successful submission
        }
      })
      .catch((error) => {
        console.error('Error submitting bug report:', error);
        alert('Error: Unable to submit bug report.');
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

.reported-bugs-container {
  max-width: 900px;
  margin: 0 auto;
}

.h2 {
  color: rgb(59, 59, 59);
  padding: 0.5em;
}

.card-header {
  background-color: #f93943;
  color: white;
  padding: 1.2rem;
  border-bottom: none;
}

.card-header h1 {
  margin-left: -10px;
}

.search-input {
  width: 200px;
  border: solid 2px #4285f4;
}

.filter-icon {
  font-size: 1.5rem;
  color: #4285f4;
}

.table thead th {
  background-color: #f8f9fa;
  font-weight: bold;
  padding-left: 2em;
  text-align: left;
}

.table tbody td {
  padding-left: 2em;
  text-align: left;
}



.badge {
    display: inline-block;
    width: 120px;
    text-align: center;
    padding: 0.5rem 0.5rem;
    font-size: 0.9rem;
    font-weight: bold;
    border-radius: 0.5rem;
}

.badge-reported {
  background-color: #f7a611;
  color: #ffffff;
}

.badge-done {
  background-color: #35b821;
  color: #ffffff;
}

.badge-progress {
  background-color: #2850a7; /* Green */
  color: #ffffff;
}

.table tbody td.status-column {
width: 150px;
text-align: center;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  max-width: 100%;
  background: rgba(0, 0, 0, 0.6);
  /* Dark background overlay */
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  padding: 2rem;
  border-radius: 5vh;
  max-width: 70vw;
  min-width: 80vw;
  width: 100%;

  z-index: 1000;
}
.modal_photo{
  max-width: fit-content;
  max-height: fit-content;
  width: 80%;
  height: 80%;
  
}
.photo_box{
  display: flex;
  justify-content: center; 
  align-items: center; 
  height: 100%; 
}

.carousel-item{
  max-width: fit-content;
  max-height: fit-content;
  margin: 2%;
  object-fit: contain;  /* Maintain aspect ratio and contain within the box */
  width: 100%;  /* Take full width */
  height: 25vh /* Fixed height */
}




.modal-title {
  padding-bottom: 1em;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.bg {
  background-color: rgb(255, 255, 255);
  z-index: 500;
  border-radius: 5vh;
}

.btn-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
}

.modal-footer {
  text-align: right;
}

.btn-secondary {
  background-color: #636363;
  color: white;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn-secondary:hover {
  background-color: #4285f4;
  color: white;
}

.dropdown-toggle {
  border: 1px solid black; /* Black border for dropdown button in light mode */
}

.dropdown-menu {
  border: 1px solid black; /* Black border for dropdown menu */
}


/* General dark mode styles */


/* Dark mode textbox */
.dark-textbox {
  background-color: #444;
  color: white;
  border: 1px solid #777;
}

/* Dark mode dropdown */
.dark-dropdown {
  background-color: #444;
  color: white;
  border: 1px solid #777;
}

.dark-dropdown .dropdown-item:hover {
  background-color: #555;
}


#bugName::placeholder{
  color: rgb(168, 168, 168);
}
#bugDescription::placeholder{
  color: rgb(168, 168, 168);
}
#otherLocation::placeholder{
  color: rgb(168, 168, 168);
}

</style>
