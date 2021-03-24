 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/session_registered_lecturers", type: :request do
  # SessionRegisteredLecturer. As you add validations to SessionRegisteredLecturer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      SessionRegisteredLecturer.create! valid_attributes
      get session_registered_lecturers_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      session_registered_lecturer = SessionRegisteredLecturer.create! valid_attributes
      get session_registered_lecturer_url(session_registered_lecturer)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_session_registered_lecturer_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      session_registered_lecturer = SessionRegisteredLecturer.create! valid_attributes
      get edit_session_registered_lecturer_url(session_registered_lecturer)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new SessionRegisteredLecturer" do
        expect {
          post session_registered_lecturers_url, params: { session_registered_lecturer: valid_attributes }
        }.to change(SessionRegisteredLecturer, :count).by(1)
      end

      it "redirects to the created session_registered_lecturer" do
        post session_registered_lecturers_url, params: { session_registered_lecturer: valid_attributes }
        expect(response).to redirect_to(session_registered_lecturer_url(SessionRegisteredLecturer.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new SessionRegisteredLecturer" do
        expect {
          post session_registered_lecturers_url, params: { session_registered_lecturer: invalid_attributes }
        }.to change(SessionRegisteredLecturer, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post session_registered_lecturers_url, params: { session_registered_lecturer: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested session_registered_lecturer" do
        session_registered_lecturer = SessionRegisteredLecturer.create! valid_attributes
        patch session_registered_lecturer_url(session_registered_lecturer), params: { session_registered_lecturer: new_attributes }
        session_registered_lecturer.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the session_registered_lecturer" do
        session_registered_lecturer = SessionRegisteredLecturer.create! valid_attributes
        patch session_registered_lecturer_url(session_registered_lecturer), params: { session_registered_lecturer: new_attributes }
        session_registered_lecturer.reload
        expect(response).to redirect_to(session_registered_lecturer_url(session_registered_lecturer))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        session_registered_lecturer = SessionRegisteredLecturer.create! valid_attributes
        patch session_registered_lecturer_url(session_registered_lecturer), params: { session_registered_lecturer: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested session_registered_lecturer" do
      session_registered_lecturer = SessionRegisteredLecturer.create! valid_attributes
      expect {
        delete session_registered_lecturer_url(session_registered_lecturer)
      }.to change(SessionRegisteredLecturer, :count).by(-1)
    end

    it "redirects to the session_registered_lecturers list" do
      session_registered_lecturer = SessionRegisteredLecturer.create! valid_attributes
      delete session_registered_lecturer_url(session_registered_lecturer)
      expect(response).to redirect_to(session_registered_lecturers_url)
    end
  end
end